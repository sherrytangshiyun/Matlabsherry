function T = structure_T(m)
% 1.复高斯随机传输矩阵生成
    p = normrnd(0,0.02,m,m); %实部 生成均值为0，方差为0.02的正态分布，行数和列数为m.
    q = normrnd(0,0.02,m,m); %虚部
    T = p+1i*q;
    T = orth(T); %正交化
% 2.奇异值分解
    [U,S,V] = svd(T);
    T = T/max(max(S));
