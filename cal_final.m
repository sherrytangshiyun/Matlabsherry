function final = cal_final(member1)

Ein = zeros(1200,1920);

A1 = member1(:,1:8);%第一个区域
A2 = member1(:,9:14);
A3 = member1(:,15:20); %细分区域
A4 = member1(:,21:28);
A5 = member1(:,29:178); %第五个区域
A6 = member1(:,179:278);
A7 = member1(:,279:378);
A8 = member1(:,379:528);
A9 = member1(:,529:928);
A10 = member1(:,929:1128);
A11 = member1(:,1129:2028);
A12 = member1(:,2029:2228);
A13 = member1(:,2229:2628);


A011 = reshape(A1,8,1); %将五个区域换算成矩阵
A012 = reshape(A2,1,6);
A013 = reshape(A3,1,6);
A014 = reshape(A4,8,1);
A015 = reshape(A5,30,5);
A016 = reshape(A6,5,20);
A017 = reshape(A7,5,20);
A018 = reshape(A8,30,5);
A019 = reshape(A9,40,10);
A0110 = reshape(A10,10,20);
A0111 = reshape(A11,30,30);
A0112 = reshape(A12,10,20);
A0113 = reshape(A13,40,10);

NN1 = 150;                        %分别将五个区域扩大
NN2 = 30;
NN3 = 15;
NN4 = 10;

for j = 1:8 %将第一个区域的矩阵扩展成1200*400
    for p = 1:1
        Ein11(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A011(j,p)*ones(NN1);
    end
end

for j = 1:1 %将第2个区域的矩阵扩展成400*400
    for p = 1:6
        Ein12(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A012(j,p)*ones(NN1);
    end
end

for j = 1:1 %将第3个区域的矩阵扩展成400*400
    for p = 1:6
        Ein13(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A013(j,p)*ones(NN1);
    end
end

for j = 1:8 %将第4个区域的矩阵扩展成400*400
    for p = 1:1
        Ein14(NN1*(j-1)+1:NN1*j,NN1*(p-1)+1:NN1*p) = A014(j,p)*ones(NN1);
    end
end

for j = 1:30 %将第5个区域的矩阵扩展成1200*400
    for p = 1:5
        Ein15(NN2*(j-1)+1:NN2*j,NN2*(p-1)+1:NN2*p) = A015(j,p)*ones(NN2);
    end
end

for j = 1:5 %将第5个区域的矩阵扩展成1200*400
    for p = 1:20
        Ein16(NN2*(j-1)+1:NN2*j,NN2*(p-1)+1:NN2*p) = A016(j,p)*ones(NN2);
    end
end

for j = 1:5 %将第5个区域的矩阵扩展成1200*400
    for p = 1:20
        Ein17(NN2*(j-1)+1:NN2*j,NN2*(p-1)+1:NN2*p) = A017(j,p)*ones(NN2);
    end
end

for j = 1:30 %将第5个区域的矩阵扩展成1200*400
    for p = 1:5
        Ein18(NN2*(j-1)+1:NN2*j,NN2*(p-1)+1:NN2*p) = A018(j,p)*ones(NN2);
    end
end

for j = 1:40 %将第5个区域的矩阵扩展成1200*400
    for p = 1:10
        Ein19(NN3*(j-1)+1:NN3*j,NN3*(p-1)+1:NN3*p) = A019(j,p)*ones(NN3);
    end
end

for j = 1:10 %将第5个区域的矩阵扩展成1200*400
    for p = 1:20
        Ein110(NN3*(j-1)+1:NN3*j,NN3*(p-1)+1:NN3*p) = A0110(j,p)*ones(NN3);
    end
end


for j = 1:30 %将第5个区域的矩阵扩展成1200*400
    for p = 1:30
        Ein111(NN4*(j-1)+1:NN4*j,NN4*(p-1)+1:NN4*p) = A0111(j,p)*ones(NN4);
    end
end

for j = 1:10 %将第5个区域的矩阵扩展成1200*400
    for p = 1:20
        Ein112(NN3*(j-1)+1:NN3*j,NN3*(p-1)+1:NN3*p) = A0112(j,p)*ones(NN3);
    end
end


for j = 1:40 %将第5个区域的矩阵扩展成1200*400
    for p = 1:10
        Ein113(NN3*(j-1)+1:NN3*j,NN3*(p-1)+1:NN3*p) = A0113(j,p)*ones(NN3);
    end
end


Ein(1:1200,361:510) = Ein11;
Ein(1:150,511:1410) = Ein12;
Ein(1051:1200,511:1410) = Ein13;
Ein(1:1200,1411:1560) = Ein14;
Ein(151:1050,511:660) = Ein15;
Ein(151:300,661:1260) = Ein16;
Ein(901:1050,661:1260) = Ein17;
Ein(151:1050,1261:1410) = Ein18;
Ein(301:900,661:810) = Ein19;
Ein(301:450,811:1110) = Ein110;
Ein(451:750,811:1110) = Ein111;
Ein(751:900,811:1110) = Ein112;
Ein(301:900,1111:1260) = Ein113;

final = Ein;







% 圆环调制，调制个数为600个
% Ein = zeros(1200,1920);
% xx = 1;
% yy = 600;
% Ein0 = 255*rand(xx,yy);
% 
% x0 = 960;
% y0 = 600;
% [x,y]=meshgrid(1:1920,1:1200);
% r0 = yy;
% for i = 1:yy
%      ri = sqrt((x-x0).^2+(y-y0).^2) <= r0; %监测区域大小 10像素是半径
%      Ein(ri)= Ein0(:,i);
%      r0 = r0-1;
% end 


% 圆环调制，内部精细程度高，外部用圆环(中心调制300*300)（5*5合并）
% Ein = zeros(1200,1920);
% xx = 1;
% yy = 2535;
% Ein0 = 255*rand(xx,yy);
% 
% x0 = 960;
% y0 = 600;
% [x,y]=meshgrid(1:1920,1:1200);
% r0 = 600;
% for i = 150:600
%      ri = sqrt((x-x0).^2+(y-y0).^2) <= r0; %监测区域大小 10像素是半径
%      Ein(ri)= Ein0(:,i);
%      r0 = r0-1;
%      if r0 == 150
%          break;
%      end
% end 
% 
% %最中心的300*300的区域，5*5合并调制，总共3600个调制单元
% A = Ein0(:,301:3900);
% [m,n] = size(A);
% NN = 5;
% A1 = reshape(A,60,60);
% 
% for j = 1:60 %将60*60矩阵扩展成300*300
%     for p = 1:60
%         Einf(NN*(j-1)+1:NN*j,NN*(p-1)+1:NN*p) = A1(j,p)*ones(NN);
%     end
% end
% 
% Ein(451:750,811:1110) = Einf;
% final = Ein;
% % Ein = uint8(Ein);
% % imshow(Ein)

% 
% 圆环调制，内部精细程度高，外部用圆环(中心调制500*500)（10*10合并）
% Ein = zeros(1200,1920);
% x0 = 960;
% y0 = 600;
% [x,y]=meshgrid(1:1920,1:1200);
% r0 = 600;
% for i = 250:600
%      ri = sqrt((x-x0).^2+(y-y0).^2) <= r0; %监测区域大小 10像素是半径
%      Ein(ri)= member1(:,i);
%      r0 = r0-10;
%      if r0 == 250
%          break;
%      end
% end 

% %最中心的300*300的区域，5*5合并调制，总共3600个调制单元
% tic
% for n = 1:35
% %  for i = 1:1200
% %     for j = 1:1920
% %         if Ein(i,j) == n
% %             Ein(i,j) = member1(1,n);
% %         end  
% %     end
% %  end   
%      [i,j] = find(Ein == n);
%      [x,y] = size(i);
%      for z = 1:x
%       Ein(i(z,:),j(z,:)) = member1(1,n);
% %      Ein(i,j) = member(1,n);
%      end
% end
% 
% A = member1(:,36:2535);
% NN = 10;
% A1 = reshape(A,50,50);
% 
% for j = 1:50 %将60*60矩阵扩展成300*300
%     for p = 1:50
%         Einf(NN*(j-1)+1:NN*j,NN*(p-1)+1:NN*p) = A1(j,p)*ones(NN);
%     end
% end
% 
% Ein(351:850,711:1210) = Einf;
% final = Ein;
% toc


