
%---------------圆环改进遗传算法----------------
%                 生成高斯光束
%             高斯光束整个衍射过程
%
function  yanshetu = gaosiguangshudechuanbo(member,N,T,w0)
L = 4*w0;               %将矩阵转化为实际的大小，单位为（cm）
lambda = 6.71e-5;       %波长，单位为（cm）
k = 2*pi/lambda;        %波矢
z = 10;                 %空间光调制器到透镜之间的传播距离，单位为（cm）
z1 = 15;                %透镜之后的传播到散射体的距离，单位为（cm）
z2 = 5;                 %散射体出来的光场传播到观察面的距离，单位为（cm）
dx = L/(N-1);               %采样间隔
f =20;                  %透镜焦距，单位为（cm）

A = (-L/2:L/(N-1):L/2);
B = ones(length(A),1)*A;
C = A'*ones(1,length(A));
Gau = exp((-(B.^2+C.^2))/(w0^2)); %产生高斯光束
Gau0 = (1/sum(sum(Gau)))*Gau;     %高斯光束光强归一化
Gau1 = Gau0.*member;              %添加相位之后的高斯光束

delta_u = 1/(N*dx);
delta_v = 1/(N*dx);      

%以下是高斯光束传播一段距离之后，经过透镜和散射矩阵，再传播一段距离到CCD表面的过程      
cycle = zeros(N,N);              
r = 2*w0;                                           %透镜的半径 
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
   

U1 = reshape(U1,1,N^2);
Z = U1*T;
Z = reshape(Z,N,N);
H1 = exp(1i*k*z2)*exp(-1i*lambda*pi*z2*(((F-N/2)*delta_u).^2+((E-N/2)*delta_v).^2));%计算传递函数
U2 = ifft2(fftshift(H1).*fft2(Z)*dx*dx)*delta_u*delta_v*N*N; 


yanshetu = abs(power(U2,2));
