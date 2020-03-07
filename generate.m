function Offspring = generate(pop,cost,N,R) %产生后代 R是变异概率
p_cost = cost/sum(cost);
p_cost = cumsum(p_cost); %概率求和排序
fitin = 1;
newin = 1;
ma_cost = rand;
pa_cost = rand;
ma = zeros(N);
pa = zeros(N);
while newin == 1 %选择父母
    if ma_cost <= p_cost(fitin)
        ma = pop{1,fitin};
        newin = newin + 1;
    else
        fitin = fitin + 1;
    end
end

newin = 1;
fitin = 1;
% pain = 1;
% 
% while pain ==1
    while newin == 1
        if pa_cost <= p_cost(fitin) 
            pa = pop{1,fitin};
            newin = newin + 1;
        else
            fitin = fitin + 1;
        end
    end
%     if pa == ma
%         pain = 1;
%         newin = 1;
%         fitin = 1;
%         pa_cost = rand;
%     else
%         pain = 0;
%     end
% end


%生成后代
T0 = rand(N,N);
T0(T0>=0.5) = 1;
T0(T0<0.5) = 0; %生成0,1随机矩阵
Offspring = ma.*T0 + pa.*(1-T0);

for i = 1:N   %后代变异
    for j = 1:N
        if rand < R
            Offspring(i,j) = exp(1i*(-pi+pi*rand));
        end
    end
end



