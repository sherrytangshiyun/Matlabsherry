function cost = cal_cost(member,N,T,target)
%º∆À„  ”¶∂»
Ein = reshape(member,N^2,1);
Eout = T*Ein;
cost = abs(Eout(target))^2;