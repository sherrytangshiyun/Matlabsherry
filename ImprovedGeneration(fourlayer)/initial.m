clear 
clc 
cam = 1;
ScreenNum = 2; %空间光调制器屏幕编号
% b = 6;
Ein = zeros(1920,1200);
Screen('Preference', 'SkipSyncTests', 1);
[w,wRect] = Screen('OpenWindow',ScreenNum); %打开屏幕
GratingIndex=Screen('MakeTexture',w,Ein);
GRect=Screen('Rect',GratingIndex);
cGRect=CenterRect(GRect,wRect);
Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
Screen(w,'Flip');   
pause(0.3);
LucamCameraOpen(cam);%打开ccd
LucamShowPreview(cam);  
LucamSetExposure(36,cam);
LucamSetGain(1,cam);

bg = zeros(1,1000);
% cost1 = zeros(1,1000);
for i = 1:200000
    Eout0 = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像
%     cost1(1,i) = sum(sum(Eout0))/(1040*1392);
%     cost(1,i) = sum(sum(Eout0((1040/2-b):(1040/2+b),(1392/2-b):(1392/2+b))))/(2*b+1)^2;
    i
    bg(1,i) = sum(sum(Eout0))/(1040*1392);
%     cost(1,i)
    bg(1,i)
    pause(1);
end
figure(1)
plot(bg);
% figure(2)
% plot(cost1);

