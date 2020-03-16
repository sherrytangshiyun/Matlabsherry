function pop = initpop(popsize,xx,yy)
%初始种群
pop = cell(1,popsize);
%选择内圈圆环
% x0 = xx/2+10;
% y0 = yy/2-12;
% r0 = 8;
% [x,y]=meshgrid(1:yy,1:xx);
% rnei = sqrt((x-x0).^2+(y-y0).^2) <= r0;
% neihuan = double(rnei);  
% 
% %选择外圈圆环
% r2 = 20;
% rwai = sqrt((x-x0).^2+(y-y0).^2) <= r2;
% waihuan = double(rwai);
% yuanhuan = waihuan-neihuan;
% A = zeros(xx,yy);
% % A(1:xx/2,1:yy/2) = 1;
% for i = 1:xx
%     for j =1:yy
%         if mod(i,2)==0 && mod(j,2)==0
%             A(i,j) = 1;
%         end
%     end
% end

for i = 1 : popsize
    Ein0 = 255*rand(xx,yy);
    pop{1,i} = Ein0;
end
