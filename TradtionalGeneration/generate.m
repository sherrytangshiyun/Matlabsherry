function Offspring = generate(pop,cost,R,xx,yy) %产生后代 R是变异概率
p_cost = cost/sum(cost);
p_cost = cumsum(p_cost); %概率求和排序
fitin = 1;
newin = 1;
ma_cost = rand;
pa_cost = rand;
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
pain = 1;

while pain ==1
    while newin == 1
        if pa_cost <= p_cost(fitin) 
            pa = pop{1,fitin};
            newin = newin + 1;
        else
            fitin = fitin + 1;
        end
    end
    if pa == ma
        pain = 1;
        newin = 1;
        fitin = 1;
        pa_cost = rand;
    else
        pain = 0;
    end
end


%生成后代
T0 = rand(xx,yy);
T0(T0>=0.5) = 1;
T0(T0<0.5) = 0; %生成0,1随机矩阵
Offspring = ma.*T0 + pa.*(1-T0);

% % x0 = xx/2+10;
% % y0 = yy/2-12;
% % r0 = 8;
% % [x,y]=meshgrid(1:yy,1:xx);
% % rnei = sqrt((x-x0).^2+(y-y0).^2) <= r0;
% r1 = w0;                                          %中心圆环的的半径，占86.5%的能量 
% x1=linspace(-2*r1,2*r1,N);             
% y1=linspace(-2*r1,2*r1,N); 
% [m1,n1] = meshgrid(x1,y1);
% D = (m1.^2+n1.^2).^(1/2);                        %圆函数关系式，（0，0）是圆心坐标
% q1 = find(D<=r1);                                  %确定透镜圆孔区域
% % neihuan = double(rnei);  

% % %选择外圈圆环
% % r2 = 20;
% % rwai = sqrt((x-x0).^2+(y-y0).^2) <= r2;
% % waihuan = double(rwai);
% % yuanhuan = waihuan-neihuan;

% A = zeros(xx,yy);
% % A(1:xx/2,1:yy/2) = 1;
% for i = 1:xx
%     for j =1:yy
%         if mod(i,2)==0 && mod(j,2)==0
%             A(i,j) = 1;
%         end
%     end
% end

for i = 1:xx   %后代变异
    for j = 1:yy
        if rand < R
            Offspring(i,j) = 255*rand;
        end
    end
end
% Offspring = yuanhuan.*Offspring;
% Offspring = A.*Offspring;


