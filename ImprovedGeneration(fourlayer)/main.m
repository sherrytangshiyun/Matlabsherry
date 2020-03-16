% clear 
% clc 
tic
% load ('C:\Users\xjtu\Desktop\waihuanxiangwei','waihuanxianwgei')

% NN = 30;          %将30个像素合并调制
% xx = 1200/NN;
% yy = 1920/NN;

%内外环精细程度不一致

xx = 1;
yy = 2628;
Ein0 = zeros(xx,yy);


k = 1000;%循环次数
ScreenNum = 2; %空间光调制器屏幕编号
cam = 1; %ccd编号
Screen('Preference', 'SkipSyncTests', 1);
b = 4;
popsize = 32;   %种群大小
G = popsize/2;  %每次循环生成的子代数
result = zeros(1,k);
time = zeros(1,k);
% Ein0 = zeros(xx,yy);%合并后的相位调制大小
% Ein = zeros(1200,1920);
% Ein = zeros(1200,1200);
% bg = zeros(1,100);
% bg0 = zeros(1,100);
cost = zeros(1,popsize+G);
[w,wRect] = Screen('OpenWindow',ScreenNum); %打开屏幕

LucamCameraOpen(cam);%打开ccd
LucamShowPreview(cam);
LucamSetExposure(20,cam);
LucamSetGain(1,cam);

% GratingIndex=Screen('MakeTexture',w,Ein0);
% GRect=Screen('Rect',GratingIndex);
% cGRect=CenterRect(GRect,wRect);
% Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
% Screen(w,'Flip');   
% pause(0.3);

bg0 = zeros(1,100);
for i = 1:100
    Eout00 = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像
    Eout00 = Eout00(1:1040,101:1355);
    bg0(1,i) = sum(sum(Eout00))/(1040*1355);
    bg0(1,i)
    i
end
i00 = sum(bg0)/100;


% Ein = zeros(1200,1920);
% x0 = 960;
% y0 = 600;
% [x,y]=meshgrid(1:1920,1:1200);
% r0 = 600;
% j = 1;
% for i = 250:600
%      ri = sqrt((x-x0).^2+(y-y0).^2) <= r0; %监测区域大小 10像素是半径
%      Ein(ri)= j;
%      r0 = r0-10;
%      j = j+1;
%      if r0 == 250
%          break;
%      end
% end 

% % Eout0 = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像
% ita0 = cal_cost(Ein0,b,w,wRect,cam);
% % ita02 = sum(sum(Eout0((1040/2+200-b):(1040/2+200+b),(1392/2-300-b):(1392/2-300+b))))/(2*b+1)^2;
% % ita0 = ita01*ita02;
% result(1,1) = ita0;
% ita0
% % i0
% pause(0.3);

pop = initpop(popsize,xx,yy); %初始种群
for i = 1:popsize %计算适应度
    cost(1,i) = cal_cost(pop{1,i},b,w,wRect,cam);
end

while all(~(diff(cost)))
    pop = initpop(popsize,xx,yy);
    for i = 1:popsize %计算适应度
        cost(1,i) = cal_cost(pop{1,i},b,w,wRect,cam);
    end
    fprintf('error');
end

[pop,cost] = paixu(pop,cost,popsize); %按照适应度排序

%变异，R0是初始变异概率，Rend是最终变异概率，lamda是衰减因子
R0 = 0.03;
Rend = 0.0025;
lamda = 200;
m = 1;   %循环次数
R = R0;

while m < k
    t = cputime;
    m
    if mod(m,300)==0
        Screen('CloseAll');
        [w,wRect] = Screen('OpenWindow',ScreenNum);
        for i = 1:popsize %计算适应度
            cost(1,i) = cal_cost(pop{1,i},b,w,wRect,cam);
        end
    end
    
    
    if m > 100
        if all(~(diff(result(1,m-100:m))))
            pop(popsize/2+1:popsize) = initpop(popsize/2,xx,yy);
            for i = 1:popsize/2
                cost(1,popsize/2+i) = cal_cost(pop{1,popsize/2+i},b,w,wRect,cam);
            end
            [pop,cost] = paixu(pop,cost,popsize);
        end
    end
    
    if all(~(diff(cost)))
        pop(popsize/2+1:popsize) = initpop(popsize/2,xx,yy);
        for i = 1:popsize/2
            cost(1,popsize/2+i) = cal_cost(pop{1,popsize/2+i},b,w,wRect,cam);
        end
        [pop,cost] = paixu(pop,cost,popsize);
    end 
    
    
    
    for i = 1:G
        Offspring = generate(pop,cost,R,xx,yy); %产生后代
        cost_Offspring = cal_cost(Offspring,b,w,wRect,cam); %计算后代适应度
        [pop,cost] = Add_Offspring(pop,cost,Offspring,cost_Offspring,popsize+i); %将后代加入种群
    end
    
    [pop,cost] = paixu(pop,cost,popsize+G);
    pop = pop(1,1:popsize);
    cost = cost(1,1:popsize);
    R = (R0-Rend)*exp(-m/lamda)+Rend;
    result(1,m) = cost(1,1);
    m = m + 1;
    figure(1)
    plot(result/i00);
    cost(1,1)
    time(1,m) = cputime - t;
    figure(2)
    plot(time)
    
end

% for j = 1:xx %将32*18的矩阵扩展成1920*1080
%     for p = 1:yy
%         Ein(NN*(j-1)+1:NN*j,NN*(p-1)+1:NN*p) = pop{1,1}(j,p)*ones(NN);
%     end
% end

Ein = cal_final(pop{1,1});


GratingIndex=Screen('MakeTexture',w,Ein);
GRect=Screen('Rect',GratingIndex);
cGRect=CenterRect(GRect,wRect);
Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
Screen(w,'Flip');   
pause(0.3);
Eout = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像


GratingIndex=Screen('MakeTexture',w,Ein0);
GRect=Screen('Rect',GratingIndex);
cGRect=CenterRect(GRect,wRect);
Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
Screen(w,'Flip');   
pause(0.3);

% for i = 1:100
%     Eout00 = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像
%     Eout00 = Eout00(1:1040,101:1392);
%     bg0(1,i) = sum(sum(Eout00))/(1040*1292);
%     i
%     bg0(1,i)
%     pause(1);
% end
% i00 = sum(bg0)/100;


% GratingIndex=Screen('MakeTexture',w,Ein);
% GRect=Screen('Rect',GratingIndex);
% cGRect=CenterRect(GRect,wRect);
% Screen('DrawTexture',w,GratingIndex,cGRect,wRect);
% Screen(w,'Flip');   
% pause(0.3);
% Eout = rgb2gray(LucamCaptureFrame(cam)); %采集ccd一帧图像
% final = sum(sum(Eout((1040/2-b):(1040/2+b),(1392/2-b):(1392/2+b))))/(2*b+1)^2;
% final2 = sum(sum(Eout((1040/2+100-b):(1040/2+100+b),(1392/2-200-b):(1392/2-200+b))))/(2*b+1)^2;
% final = final1*final2;
% % enhencement = result/i00;
% % enhencement = enhencement';
figure(3)
% plot(enhencement);

imagesc(Eout)
colormap('jet')
colorbar
% final
cost
toc












