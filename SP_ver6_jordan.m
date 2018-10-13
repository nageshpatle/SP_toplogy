tic
Rsw=1;
RL=1e3;
C1=8.65e-6;
C2=8.65e-6;
CL=86.5e-6;

n=10000;    %no. of phase1-phase2 cycles
f=1;   %freq of operation
nos=1000;  %no. of samples in a  complete cycle
duty=0.5;%duty cycle

a1=[-1/(2*C1*Rsw) -1/(2*C1*Rsw) 1/(2*C1*Rsw);
    -1/(2*C2*Rsw) -1/(2*C2*Rsw) 1/(2*C2*Rsw);
    1/(2*CL*Rsw)  1/(2*CL*Rsw)  (1/CL)*((-1/RL)-(1/(2*Rsw)))];

b1=[-1/(2*C1*Rsw) ; -1/(2*C2*Rsw); 1/(2*CL*Rsw)];

c1=[0 0 1];
d1=0;

a2=[-1/(2*C1*Rsw)  0             0;
    0            -1/(2*C2*Rsw)  0;
    0             0            -1/(CL*RL)];

b2=[1/(2*C1*Rsw) ; 1/(2*C2*Rsw);  0];
c2=[0 0 1];
d2=0;
vin=5;
time=1/(f*nos)*(1:n*nos);
X=zeros(4,n*nos);
x0=[0 0 0];

% x1000 = (((M1^(nos/2))*(M2^(nos/2)))^1000)*[x0'; vin*b1];
% xx = expmdemo1(t*[a1 eye(3); zeros(3) zeros(3)])*[x0'; vin*b1];
% x_t = xx(1:3);

t=1/(f*nos);
M1=expm(t*[a1 b1; zeros(1,3) zeros(1)]);
M2=expm(t*[a2 b2; zeros(1,3) zeros(1)]);


for j=(1:nos*duty)
    X(:,j)=(M1^j)*[x0'; vin];
end
for j=(nos*duty+1:nos)
    X(:,j)=(M2^j)*(M1^(nos*duty))*[x0'; vin];
end

for i=2:n
    for j=(1+(i-1)*nos:nos*duty+(i-1)*nos)
        X(:,j)=M1*X(:,j-1);
    end
    for j=(nos*duty+1+(i-1)*nos:i*nos)
        X(:,j)=M2*X(:,j-1);
    end
end

time=[0 time];
X=[[0;0;0;0] X];
x1=X(1,:);
x2=X(2,:);
x3=X(3,:);
toc
plot(time,x1);

P=(M2^(nos/2))*(M1^(nos/2));
%xx = (((M2^(nos/2))*(M1^(nos/2)))^2)*[x0'; vin];
%xx = M1*[x0'; vin];

% (M2^(nos/2))*(M1^(nos/2))-(M1^(nos/2))*(M2^(nos/2))
%
% expmdemo1(t*[a1 b1; ones(1,3) ones(1)]+t*[a2 b2; ones(1,3) ones(1)]);
% expmdemo1(t*[a2 b2; ones(1,3) ones(1)]+t*[a1 b1; ones(1,3) ones(1)]);
