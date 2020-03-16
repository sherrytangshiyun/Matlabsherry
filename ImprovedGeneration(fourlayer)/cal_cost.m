function cost = cal_cost(member1,b,w,wRect,cam)
%计算适应度
%将矩阵载入空间光调制器    
% for j = 1:xx %将32*18的矩阵扩展成1920*1080
%     for p = 1:yy
%         member(NN*(j-1)+1:NN*j,NN*(p-1)+1:NN*p) = member1(j,p)*ones(NN);
%     end
% end
Ein = cal_final(member1);

% Ein = zeros(1200,1920);
% 
% A1 = member1(:,1:300);%第一个区域
% A2 = member1(:,301:400);
% A3 = member1(:,401:2900); %细分区域
% A4 = member1(:,2901:3000);
% A5 = member1(:,3001:3300); %第五个区域
% 
% A11 = reshape(A1,30,10); %将五个区域换算成矩阵
% A12 = reshape(A2,10,10);
% A13 = reshape(A3,50,50);
% A14 = reshape(A4,10,10);
% A15 = reshape(A5,30,10);
% 
% NN1 = 40;                        %分别将五个区域扩大
% NN2 = 8;
% 
% for j = 1:30 %将第一个区域的矩阵扩展成1200*400
%     for p = 1:10
%         Ein11(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A11(j,p)*ones(NN1);
%     end
% end
% 
% for j = 1:10 %将第2个区域的矩阵扩展成400*400
%     for p = 1:10
%         Ein12(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A12(j,p)*ones(NN1);
%     end
% end
% 
% for j = 1:50 %将第3个区域的矩阵扩展成400*400
%     for p = 1:50
%         Ein13(NN2*(j-1)+1:NN2*j,NN2*(p-1)+1:NN2*p) = A13(j,p)*ones(NN2);
%     end
% end
% 
% for j = 1:10 %将第4个区域的矩阵扩展成400*400
%     for p = 1:10
%         Ein14(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A14(j,p)*ones(NN1);
%     end
% end
% 
% for j = 1:30 %将第5个区域的矩阵扩展成1200*400
%     for p = 1:10
%         Ein15(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A15(j,p)*ones(NN1);
%     end
% end
% 
% Ein(361:1560,1:400) = Ein11;
% Ein(361:760,401:800) = Ein12;
% Ein(761:1160,401:800) = Ein13;
% Ein(1161:1560,401:800) = Ein14;
% Ein(361:1560,801:1200) = Ein15;
% Ein = Ein';

GratingIndex=Screen('MakeTexture',w,Ein);
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
[x,y]=meshgrid(1:1392,1:1040);
r = sqrt((x-x0).^2+(y-y0).^2) <= r0;%监测区域大小 10像素是半径
focus = Eout1(r);
int = sum(sum(focus));
cost = int/length(focus);%聚焦区域的平均强度
% focus = Eout1(662:692,445:475);
% cost = sum(sum(focus))/numel(focus);
