function [pop,cost] = paixu(pop,cost,popsize)
%按照适应度大小排序
for i = 1 : popsize-1
    for j = 1 : popsize-i
        if cost(j)<cost(j+1)
            temp1 = cost(j+1);
            cost(j+1) = cost(j);
            cost(j) = temp1;
            temp2 = pop{j+1};
            pop{j+1} = pop{j};
            pop{j} = temp2;
        end
    end
end