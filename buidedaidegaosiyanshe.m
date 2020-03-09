%高斯传播

%---------------圆环改进遗传算法----------------
%                 生成高斯光束
%             高斯光束整个衍射过程
%
%
clear;
N =  512;                 %入射高斯光束矩阵的维度大小
w0 = 0.1;                 %高斯光束束腰半径,单位为（cm）

L = 4*w0;                 %将矩阵转化为实际的大小，单位为（cm）
lambda = 6.71e-5;       %波长，单位为（cm）
k = 2*pi/lambda;        %波矢
z = 10;                 %空间光调制器到透镜之间的传播距离，单位为（cm）
z1 = 15;                %透镜之后的传播到散射体的距离，单位为（cm）
z2 = 5;                 %散射体出来的光场传播到观察面的距离，单位为（cm）
dx = L/(N-1);               %采样间隔
f =20;                  %透镜焦距，单位为（cm）
% T = structure_T(N^2);
phase = ones(N);


A = (-L/2:L/(N-1):L/2);
B = ones(length(A),1)*A;
C = A'*ones(1,length(A));
Gau = exp((-(B.^2+C.^2))/(w0^2)); %产生高斯光束
Gau1 = (1/sum(sum(Gau)))*Gau;     %高斯光束光强归一化
Gau1 = Gau1.*exp(1i*phase);

delta_u = 1/(N*dx);
delta_v = 1/(N*dx);      


% D = (1:1:N);
% E = ones(length(D),1)*D;
% F = D'*ones(1,length(D));
% Kx = (2*pi*(F-1))/(N*dx)-((2*pi*(N))/(N*dx))/2;
% Ky = (2*pi*(E-1))/(N*dx)-((2*pi*(N))/(N*dx))/2;
% H = exp(1i/(2*k)*z*(Kx.^2+Ky.^2));                   %空间光调制器到透镜的传递函数
% Htoujing = exp(1i/(2*k)*z1*(Kx.^2+Ky.^2));           %透镜到散射体的传递函数
% Hsansheti = exp(1i/(2*k)*z2*(Kx.^2+Ky.^2));          %散射体到观察面的传递函数
% 
% 
% FGau = fftshift(fft2(Gau1));
% Gauout = FGau.*H;                                %高斯光束传播一段距离之后的光场


%以下是高斯光束传播一段距离之后，经过透镜和散射矩阵，再传播一段距离到CCD表面的过程      
cycle = zeros(N,N);        
% T = structure_T(N);      
r = 2.5*w0;                                           %透镜的半径 
x1=linspace(-r,r,N);             
y1=linspace(-r,r,N); 
[m1,n1] = meshgrid(x1,y1);
D = (m1.^2+n1.^2).^(1/2);                        %圆函数关系式，（0，0）是圆心坐标
q = find(D<=r);                                  %确定透镜圆孔区域
cycle(q) = 1;       

toujing = cycle.*exp(-1i*k.*(C.^2+B.^2)./(2*f));%计算透镜的二次曲率


D = [1:1:N];
E = ones(length(D),1)*D;
F = D'*ones(1,length(D));
H = exp(1i*k*z)*exp(-1i*lambda*pi*z*(((F-N/2)*delta_u).^2+((E-N/2)*delta_v).^2));%高斯光束衍射的传递函数

H0 = exp(1i*k*z1)*exp(-1i*lambda*pi*z1*(((F-N/2)*delta_u).^2+((E-N/2)*delta_v).^2));  %计算从SLM到透镜的传递函数
U0 = ifft2(fftshift(H).*fft2(Gau1)*dx*dx)*delta_u*delta_v*N*N;            %到达透镜前表面的光场

U0 = U0.*toujing;%透镜后表面的光场
U1 = ifft2(fftshift(H0).*fft2(U0)*dx*dx)*delta_u*delta_v*N*N;%透镜后表面的光场衍射15cm
   
T = ones(N,N);
% U1 = reshape(U1,1,N^2);
% Z = U1*T;
% Z = reshape(Z,N,N);
Z = U1.*T;
H1 = exp(1i*k*z2)*exp(-1i*lambda*pi*z2*(((F-N/2)*delta_u).^2+((E-N/2)*delta_v).^2));%计算传递函数
U2 = ifft2(fftshift(H1).*fft2(Z)*dx*dx)*delta_u*delta_v*N*N; 

% % Toujing = Gauout.*(cycle.*exp(-1i*k.*(C.^2+B.^2)./(2*f))); %透镜的二次曲率，是透镜的光瞳函数乘以透镜的透过率函数   
% % Tout = fftshift(fft2(Toujing));
% % Tout1 = Tout.*Htoujing;                                    % 透镜出来的光场
% % Tout = ifft2(fftshift(Htoujing).*fft2(Toujing)*dx*dx)*(1/(N*dx))^2*N*N;
% 
% % Tout = ifft2(fftshift(Htoujing).*fft2(Toujing));             % 从透镜出来的光场
% 
% Tout = ifft2(fftshift(fft2(Toujing)).*Htoujing);
% 
% 
% Tout1 = reshape(Tout,1,N^2);
% Z = Tout1*T;                                                 % 透镜传输到散射体，散射体后表面的光场
% Z1 = reshape(Z,N,N);
% % Zout = ifft2(fftshift(Hsansheti).*fft2(Z));                  % 经过散射体传播到观察面的光场
% Zout = ifft2(fftshift(fft2(Z1)).*Hsansheti);

% w1 = abs(Gauout)^2;
% w2 = abs(Tout)^2;
% w3 = abs(Zout)^2;

subplot(2,3,1),
I = abs(U0)^2;                                              %最终到观察面上的光强

% x = 1:1:N;
% y = 1:1:N;
% x = (x-1)*dx;
% y = (y-1)*dx;
% mesh(x,y,I) %绘制最终光场的三维立体图

% plot(I)
imagesc(I)
colormap('jet') %绘制最终光场的彩图，着色方式为jet
colorbar

subplot(2,3,2),
I1 = abs(U1)^2;
imagesc(I1)
colormap('jet') %绘制最终光场的彩图，着色方式为jet
colorbar


subplot(2,3,3),
I2 = abs(U2)^2;
imagesc(I2)
colormap('jet') %绘制最终光场的彩图，着色方式为jet
colorbar

% subplot(3,3,4),
% I3 = abs(Tout)^2;
% imagesc(I3)
% colormap('jet') %绘制最终光场的彩图，着色方式为jet
% colorbar

subplot(2,3,4)
mesh(I)

subplot(2,3,5)
mesh(I1)

subplot(2,3,6)
mesh(I2)

% subplot(3,3,8)
% mesh(I3)



   
        
        
        
