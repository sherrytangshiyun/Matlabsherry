
cost2 = zeros(1,300);
x0 = xx/2+5;
y0 = yy/2-12;
r0 = 8;
[x,y]=meshgrid(1:yy,1:xx);
rnei = sqrt((x-x0).^2+(y-y0).^2) <= r0;
neihuan = double(rnei);  
% r2 = 15;
% rwai = sqrt((x-x0).^2+(y-y0).^2) <= r2;
% waihuan = double(rwai);
% yuanhuan = waihuan-neihuan;
for i = 1:255
        xiangwei = waihuanxiang+mod((neihuan.*(i*ones(40,64)+neihuanxiang)),255);
        cost2(1,i) = cal_cost(xiangwei,b,NN,xx,yy,w,wRect,cam);
end
max(cost2)