Rsw=100;
RL=1e3;
C1=1e-6;
C2=1e-6;
CL=10e-6;

n=50;    %no. of phase1-phase2 cycles
f=1e3;   %freq of operation
nos=10;  %no. of samples in a  complete cycle
duty=0.5;%duty cycle



A1=[-1/(2*C1*Rsw) -1/(2*C1*Rsw) 1/(2*C1*Rsw);
    -1/(2*C2*Rsw) -1/(2*C2*Rsw) 1/(2*C2*Rsw);
    1/(2*CL*Rsw)  1/(2*CL*Rsw)  (1/CL)*((-1/RL)-(1/2*Rsw))];

B1=[-1/(2*C1*Rsw) ; -1/(2*C2*Rsw); 1/(2*CL*Rsw)];

A2=[-1/(2*C1*Rsw)  0             0;
    0            -1/(2*C2*Rsw)  0;
    0             0            -1/(CL*RL)];

B2=[1/(2*C1*Rsw) ; 1/(2*C2*Rsw);  0];
%B2=[1/(2*C1*Rsw) ; 1/(2*C2*Rsw);  1e-30];

I=[1 0 0; 0 1 0; 0 0 1];




syms s t;
X0=[0; 0; 0];

time=zeros(n*nos,1);
x1=zeros(n*nos,1);
x2=zeros(n*nos,1);
x3=zeros(n*nos,1);


Up1(s)=5/s;
Up2(s)=5/s;
temp1=inv(s*I-A1);
temp2=(s*I-A1)\(B1*Up1);
temp3=inv(s*I-A2);
temp4=(s*I-A2)\(B2*Up2);

for i=1:n
    %Up1(s)=[5/s];
    %Xp1(s)=inv(s*I-A1)*(B1*Up1+X0);
    Xp1(s)=temp2+temp1*X0;
    xp1(t)=ilaplace(Xp1);
    
    for j=1:nos*duty
        time(j+(i-1)*nos)=(j/nos+(i-1))/f;
        a=xp1((j/(nos*f)));
        x1(j+(i-1)*nos)=double(a(1));
        x2(j+(i-1)*nos)=double(a(2));
        x3(j+(i-1)*nos)=double(a(3));
        
    end
     
    
    X0=[x1(nos*duty+(i-1)*nos-1); x2(nos*duty+(i-1)*nos-1); x3(nos*duty+(i-1)*nos-1)];
    
    %Up2(s)=[5/s];
    %Xp2(s)=inv(s*I-A2)*(B2*Up2+X0);
    Xp2(s)=temp4+temp3*X0;
    xp2(t)=ilaplace(Xp2);
    
    for j=nos*duty+1:nos
        time(j+(i-1)*nos)=(j/nos+(i-1))/f;
        a=xp2((j-nos*duty)/(nos*f));
        x1(j+(i-1)*nos)=double(a(1));
        x2(j+(i-1)*nos)=double(a(2));
        x3(j+(i-1)*nos)=double(a(3));
    end

    X0=[x1(i*nos-1); x2(i*nos-1); x3(i*nos-1)];
end

%plot(time,x1);
%hold on
%plot(time,x2,'*');
plot(time,x1);
