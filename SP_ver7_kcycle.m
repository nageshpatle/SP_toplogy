Rsw=1;
RL=1e3;
C1=8.65e-6;
C2=8.65e-6;
CL=86.5e-6;

%F=logspace(1,8,7);

F(1)=1e3;
for i=2:200
    F(i)=1.1*F(i-1);
end

for i=1:200
    f=F(i);
    n=1000;    %no. of phase1-phase2 cycles
    %f=1e3;   %freq of operation
    nos=10;  %no. of samples in a  complete cycle
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
    X=zeros(4,nos);
    
    t=1/(2*f);
    M1=expm(t*[a1 b1; zeros(1,3) zeros(1)]);
    M2=expm(t*[a2 b2; zeros(1,3) zeros(1)]);
    
    % k=100000000000;
    % Xk=((M2^(nos/2))*(M1^(nos/2)))^(k)*[x0'; vin];
    
    P1=(M2*M1);
    P=P1-eye(4);
    A=P(1:3,1:3);
    b=-vin*P(1:3,4);
    SS = linsolve(A,b);
    
    nos=1000;
    t=1/(f*nos);
    M1=expm(t*[a1 b1; zeros(1,3) zeros(1)]);
    M2=expm(t*[a2 b2; zeros(1,3) zeros(1)]);
    
    X(:,1)=M1*[SS;vin];
    for j=(2:nos*duty)
        X(:,j)=M1*X(:,j-1);
    end
    for j=(nos*duty+1:nos)
        X(:,j)=M2*X(:,j-1);
    end
    
    vrms=rms(X(3,:));
    Req(i)=RL*(3*5/vrms-1);
    Eff(i)=RL/(RL+Req(i));
end
figure
semilogx(F,Req);
figure
semilogx(F,Eff);

