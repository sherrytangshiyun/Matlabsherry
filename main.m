
tic
popsize = 32; %种群大小
N = 16; %矩阵行列数
G = popsize/2; %每次循环生成的子代数
pop = initpop(popsize,N); %初始种群
cost = zeros(1,popsize+G);
T = structure_T(N^2); %散射体传输矩阵
Target = round((N/2-1)*N+N/2); %聚焦点  round函数将参数中的每个元素四舍五入为最近的整数
result = zeros(1,3000);
for i = 1:popsize %计算适应度
    member = pop{1,i};
    cost(1,i) = cal_cost(member,N,T,Target);
end

[pop,cost] = paixu(pop,cost,popsize); %按照适应度排序

%变异，R0是初始变异概率，Rend是最终变异概率，lamda是衰减因子
R0 = 0.03;
Rend = 0.0025;
lamda = 200;
m = 1;   %循环次数
R = R0;
while m < 3000
    m
    for i = 1:G
        Offspring = generate(pop,cost,N,R); %产生后代
        cost_Offspring = cal_cost(Offspring,N,T,Target); %计算后代适应度
        [pop,cost] = Add_Offspring(pop,cost,Offspring,cost_Offspring,popsize+i); %将后代加入种群
    end
    [pop,cost] = paixu(pop,cost,popsize+G);
    pop = pop(1,1:popsize);
    cost = cost(1,1:popsize);
    R = (R0-Rend)*exp(-m/lamda)+Rend;
    result(1,m) = cost(1,1);
    m = m + 1;
    if all(~(diff(cost)))
        pop(popsize/2+1:popsize) = initpop(popsize/2,N);
        for i = 1:popsize/2
            member = pop{1,popsize/2+i};
            cost(1,popsize/2+i) = cal_cost(member,N,T,Target);
        end
        [pop,cost] = paixu(pop,cost,popsize);
    end
end
toc

cost
Ein = reshape(pop{1,1},N^2,1);
Eout = T*Ein;
Eout = reshape(Eout,N,N);
Eout = Eout';
Ein = reshape(Ein,N,N);
Ein = Ein';
Iin = abs(Ein).^2;
Pin = angle(Ein);
Iout = abs(Eout).^2;
Pout = angle(Eout);
AT = abs(T);
PT = angle(T);


figure(1)
subplot(2,2,1)
imshow(Iin,[])
colorbar
title('调制后入射光光强')

subplot(2,2,2)
imshow(Pin,[])
colorbar
title('调制后入射光相位')

subplot(2,2,3)
imshow(Iout,[])
colorbar
title('调制后出射光光强')

subplot(2,2,4)
imshow(Pout,[])
colorbar
title('调制后出射光相位');

figure(2)
plot(result);