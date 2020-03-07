function pop = initpop(popsize,N)
%初始种群
pop = cell(1,popsize);
for i = 1 : popsize
    phase = 2*pi*rand(N);  %随机相位
    pop{1,i} = exp(1i*phase);
end
