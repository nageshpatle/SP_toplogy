Rsw=1;
RL=1e6;
C1=1e-6;
C2=1e-6;
CL=10e-6;

n=1000;    %no. of phase1-phase2 cycles
f=100e3;   %freq of operation
nos=10;  %no. of samples in a  complete cycle
duty=0.5;%duty cycle

ms=5;
ns=5;
RC=zeros(ms,ns);
F=zeros(ms,ns);
Eff=zeros(ms,ns);
iin=zeros(ms,ns);
vout=zeros(ms,ns);

for a=1:ms
    f=f/1.5;
    %Rsw=1;
    C1=1e-6;
    C2=1e-6;
    for b=1:ns
       % Rsw=Rsw*2;
        C1=C1*1.5;
        C2=C2*1.5;
        CL=C1*10;
        RC(a,b)=Rsw*C1;
        F(a,b)=f;
        
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
        
        time=1/(f*nos)*(1:n*nos);
        X=zeros(3,n*nos);
        u1=5*ones(1,nos*duty+1);
        u2=5*ones(1,nos*(1-duty)+1);
        tp1=0:1/(nos*f):duty/f;
        tp2=0:1/(nos*f):(1-duty)/f;
        
        x0=[0 0 0];
        
        
        
        for i=1:n
            [~,~,x] =lsim(sys1,u1,tp1,x0);
            X(:,(1+(i-1)*nos:nos*duty+(i-1)*nos))=x(2:end,:)';
            x0=x(end,:);
            
            [~,~,x] =lsim(sys2,u2,tp2,x0);
            X(:,(nos*duty+1+(i-1)*nos:i*nos))=x(2:end,:)';
            x0=x(end,:);
        end
        
        %time=[0 time];
        X=[[0;0;0] X];
        x1=X(1,:);
        x2=X(2,:);
        x3=X(3,:);
        
        %iin=(((5+x1(end)+x2(end)-x3(end))/(2*Rsw))+(2*5-x1(end)-x2(end))/(2*Rsw))*0.5;
        
        iin(a,b)=(((5+mean(x1(end-10:end))+mean(x2(end-10:end))-mean(x3(end-10:end)))/(2*Rsw))+(2*5-mean(x1(end-10:end))-mean(x2(end-10:end)))/(2*Rsw))*0.5;
        
        % disp('iin=');disp(iin); disp('n='); disp(n);disp('m=');disp(m); disp('x3='); disp(x3(end));
        Eff(a,b)=mean(x3(end-10:end))*mean(x3(end-10:end))/(RL*5*iin(a,b));
        vout(a,b)=mean(x3(end-10:end));
       % if(F==5e6&&RC==2e-6)
        %    disp([vout(a,b) Rsw RL C1 C2 CL F(a,b) a n])
        
    end
end
surf(F,RC,Eff);
xlabel('F')
ylabel('RC')
zlabel('Eff')
