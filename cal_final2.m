function final = cal_final(member1,Ein)

% Ein = zeros(1200,1920);

% A1 = member1(:,1:300);%第一个区域
% A2 = member1(:,301:400);
% A3 = member1(:,401:2000); %细分区域
% A4 = member1(:,2001:2100);
% A5 = member1(:,2101:2400); %第五个区域
% 
% A11 = reshape(A1,30,10); %将五个区域换算成矩阵
% A12 = reshape(A2,10,10);
% A13 = reshape(A3,40,40);
% A14 = reshape(A4,10,10);
% A15 = reshape(A5,30,10);
% 
% NN1 = 40;                        %分别将五个区域扩大
% NN2 = 10;
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
% for j = 1:40 %将第3个区域的矩阵扩展成400*400
%     for p = 1:40
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
% Ein(1:1200,361:760) = Ein11;
% Ein(1:400,761:1160) = Ein12;
% Ein(401:800,761:1160) = Ein13;
% Ein(801:1200,761:1160) = Ein14;
% Ein(1:1200,1161:1560) = Ein15;
% 
% final = Ein;







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

%最中心的300*300的区域，5*5合并调制，总共3600个调制单元
for n = 1:600
%  for i = 1:1200
%     for j = 1:1920
%         if Ein(i,j) == n
%             Ein(i,j) = member1(1,n);
%         end  
%     end
%  end   
     [i,j] = find(Ein == n);
     [x,y] = size(i);
     for z = 1:x
      Ein(i(z,:),j(z,:)) = member1(1,n);
%      Ein(i,j) = member(1,n);
     end
end

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
final = Ein;



