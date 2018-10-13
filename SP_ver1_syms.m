%syms based code
%95.248272
tic
Rsw=1;
RL=1e6;
C1=1e-6;
C2=1e-6;
CL=10e-6;

n=100;    %no. of phase1-phase2 cycles
f=1e3;   %freq of operation
nos=10;  %no. of samples in a  complete cycle
duty=0.5;%duty cycle



A1=[-1/(2*C1*Rsw) -1/(2*C1*Rsw) 1/(2*C1*Rsw);
    -1/(2*C2*Rsw) -1/(2*C2*Rsw) 1/(2*C2*Rsw);
    1/(2*CL*Rsw)  1/(2*CL*Rsw)  (1/CL)*((-1/RL)-(1/(2*Rsw)))];

B1=[-1/(2*C1*Rsw) ; -1/(2*C2*Rsw); 1/(2*CL*Rsw)];

A2=[-1/(2*C1*Rsw)  0             0;
    0            -1/(2*C2*Rsw)  0;
    0             0            -1/(CL*RL)];

B2=[1/(2*C1*Rsw) ; 1/(2*C2*Rsw);  0];

I=[1 0 0; 0 1 0; 0 0 1];

digits(4);



syms s t;
X0=[0; 0; 0];

time=1/(f*nos)*(1:n*nos);
x=zeros(3,n*nos);

U(s)=5/s;
temp1=(s*I-A1)\(B1*U);
temp2=(s*I-A2)\(B2*U);
temp3=(s*I-A1)\I;
temp4=(s*I-A2)\I;

for i=1:n
    %Xp1(s)=inv(s*I-A1)*(B1*Up1+X0);
    Xp1=vpa(temp1+temp3*X0);
    xp1=vpa(ilaplace(Xp1));
    
    for j=1:nos*duty
        %x(:,j+(i-1)*nos)=double(xp1((j/(nos*f)))); %first row gives x1(t), similarly for others
        x(:,j+(i-1)*nos)=subs(xp1,t,j/(nos*f));
    end
    X0=x(:,nos*duty+(i-1)*nos);

    Xp2=vpa(temp2+temp4*X0);
    xp2=vpa(ilaplace(Xp2));
    
    for j=nos*duty+1:nos
        x(:,j+(i-1)*nos)=subs(xp2,t,(j-nos*duty)/(nos*f));
    end
    X0=x(:,i*nos);
end

x1=x(1,:);
x2=x(2,:);
x3=x(3,:);
plot(time,x3);
toc