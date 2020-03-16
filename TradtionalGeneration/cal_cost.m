function cost = cal_cost(member1,b,NN,xx,yy,w,wRect,cam)
%计算适应度
%将矩阵载入空间光调制器    
for j = 1:xx %将32*18的矩阵扩展成1920*1080
    for p = 1:yy
        member(NN*(j-1)+1:NN*j,NN*(p-1)+1:NN*p) = member1(j,p)*ones(NN);
    end
end

GratingIndex=Screen('MakeTexture',w,member);
GRect=Screen('Rect',GratingIndex);
cGRect=CenterRect(GRect,wRect);
Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
Screen(w,'Flip');   
pause(0.15);
Eout1 = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像
Eout1 = double(Eout1);
% cost = sum(sum(Eout1((1040/2-b):(1040/2+b),(1392/2-b):(1392/2+b))))/(2*b+1)^2;
x0 = 628;%yuan628
y0 = 484;%yuan484
r0 = b;
[x,y]=meshgrid(1:1390,1:1040);
r = sqrt((x-x0).^2+(y-y0).^2) <= r0;%监测区域大小 10像素是半径
focus = Eout1(r);
int = sum(sum(focus));
pingjun = int/length(focus);%聚焦区域的平均强度
cost = pingjun;

% focus = Eout1(662:692,445:475);
% cost = sum(sum(focus))/numel(focus);
