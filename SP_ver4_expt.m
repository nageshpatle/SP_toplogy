Rsw=1;
RL=1e3;
C1=8.65e-6;
C2=8.65e-6;
CL=86.5e-6;

n=1000;    %no. of phase1-phase2 cycles
f=1e6;   %freq of operation
nos=10;  %no. of samples in a  complete cycle
duty=0.7;%duty cycle

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


sys1=ss(a1,b1,c1,d1);
sys2=ss(a2,b2,c2,d2);
vin=5;
time=zeros(1,n*nos);
%time=1/(f*nos)*(1:n*nos);
X=zeros(3,n*nos);
% u1=vin*ones(1,nos*duty+1);
% u2=vin*ones(1,nos*(1-duty)+1);
% tp1=0:1/(nos*f):duty/f;
% tp2=0:1/(nos*f):(1-duty)/f;

x0=[0 0 0];



for i=1:n
    

    duty=0.2;
    tp1=0:1/(nos*f):duty/f;
    u1=vin*ones(1,nos*duty+1);
    t=0:1/(nos*f):duty/f;
    [~,~,x] =lsim(sys1,u1,tp1,x0);
    time(1+(i-1)*nos:nos*duty+(i-1)*nos)=t(2:end)+(i-1)*ones(1,length(t)-1)/f;
    X(:,(1+(i-1)*nos:nos*duty+(i-1)*nos))=x(2:end,:)';
    x0=x(end,:);
    
    
  
    duty=0.6;
    tp2=0:1/(nos*f):(1-duty)/f;
    u2=vin*ones(1,nos-nos*duty+1);
    t=0:1/(nos*f):(1-duty)/f;
    [~,~,x] =lsim(sys2,u2,tp2,x0);
    time(nos*duty+1+(i-1)*nos:i*nos)=(t(2:end)+duty/f)+(i-1)*ones(1,length(t)-1)/f;
    X(:,(nos*duty+1+(i-1)*nos:i*nos))=x(2:end,:)';
    x0=x(end,:);
end

time=[0 time];
X=[[0;0;0] X];
x1=X(1,:);
x2=X(2,:);
x3=X(3,:);

%iin=(((5+mean(x1(end-10:end))+mean(x2(end-10:end))-mean(x3(end-10:end)))/(2*Rsw))+(2*5-mean(x1(end-10:end))-mean(x2(end-10:end)))/(2*Rsw))*0.5;

%Eff=mean(x3(end-10:end))*mean(x3(end-10:end))/(RL*5*iin);

iout=x3(end-nos+1:end)/(RL);
iinp1=((vin+mean(x1(end-nos+1:end-nos*duty))+mean(x2(end-nos+1:end-nos*duty))-mean(x3(end-nos+1:end-nos*duty)))/(2*Rsw));
iinp2=(2*vin-mean(x1(end-nos*duty+1:end))-mean(x2(end-nos*duty+1:end)))/(2*Rsw);


pinp1=iinp1*vin;
pinp2=iinp2*vin;
pin=0.5*(pinp1+pinp2);
pout=mean(iout.*iout)*RL;
Eff=pout/pin;


x11=0.5*((5+iinp1*Rsw+x1)+(0.5*(5+x1)));

%plot(time,x3);

%Rout=(1/(iout^2))*(0.5*C1*x1(end)^2+0.5*C2*x2(end)^2+2*Rsw*iinp1^2+)
%pCL=0.5*CL*f*((x3(end)-x3(nos:end))^2;

%%Rout=(pin*(1-Eff))/(iout.*iout);
x1=x1(x1~=0);x2=x2(x2~=0);x3=x3(x3~=0);time=time(time~=0);
plot(time,x3,time,x1)


