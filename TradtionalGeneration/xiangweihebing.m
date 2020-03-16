
ScreenNum = 2; %空间光调制器屏幕编号
cam = 1; %ccd编号
Screen('Preference', 'SkipSyncTests', 1);
[w,wRect] = Screen('OpenWindow',ScreenNum); %打开屏幕

LucamCameraOpen(cam);%打开ccd
LucamShowPreview(cam);
LucamSetExposure(20,cam);
LucamSetGain(1,cam);
waihuan1 = zeros(xx,yy);
neihuan1 = zeros(xx,yy);
costhebing = zeros(255,255);

x0 = xx/2+10;
y0 = yy/2-12;
r0 = 8;
r1 = 20;
[x,y]=meshgrid(1:yy,1:xx);
rnei = sqrt(power((x-x0),2)+power((y-y0),2))<=r0;
rwai = sqrt(power((x-x0),2)+power((y-y0),2))<=r1;
xiaoyuan= double(rnei);
dayuan = double(rwai);
yuanhuan = dayuan-xiaoyuan;


for i = 1:255
    for j = 1:255
        waihuan1 = mod(waihuan+i.*yuanhuan,255);
        neihuan1 = mod(neihuan+j.*xiaoyuan,255);
        xiangwei = neihuan1+waihuan1;
        costhebing(i,j) = cal_cost(xiangwei,b,NN,xx,yy,w,wRect,cam);
        plot(costhebing(i,j))
        
    end
    
end
% [i,j] = max(costhebing);
% xiangwei = mod(waihuan+i.*yuanhuan,255)+mod(neihuan+j.*xiaoyuan,255);
% 
% for j = 1:xx %将32*18的矩阵扩展成1920*1080
%     for p = 1:yy
%         Ein(NN*(j-1)+1:NN*j,NN*(p-1)+1:NN*p) = xiangwei(j,p)*ones(NN);
%     end
% end
% 
% GratingIndex=Screen('MakeTexture',w,Ein);
% GRect=Screen('Rect',GratingIndex);
% cGRect=CenterRect(GRect,wRect);
% Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
% Screen(w,'Flip');   
% pause(0.3);
% Eout = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像








