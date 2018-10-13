%Iterative-recursive analysis
Rsw=1;
RL=1e3;
C1=8.65e-6;
C2=8.65e-6;
CL=86.5e-6;

n=1000;    %no. of phase1-phase2 cycles
f=1e3;   %freq of operation
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

k=0;

%sys1=ss(a1,b1,c1,d1);
%sys2=ss(a2,b2,c2,d2);

time=1/(f*nos)*(1:n*nos);
%X=zeros(3,n*nos);

vin=5;
% u1=vin*ones(1,nos*duty+1);
% u2=vin*ones(1,nos*(1-duty)+1);

% tp1=0:1/(nos*f):duty/f;
% tp2=0:1/(nos*f):(1-duty)/f;

x0=[0 0 0];
I=eye(3);


% 
% for i=1:n
%    
%     [~,~,x] =lsim(sys1,u1,tp1,x0);
%     X(:,(1+(i-1)*nos:nos*duty+(i-1)*nos))=x(2:end,:)';
%     x0=x(end,:);
%     
%     
%     [~,~,x] =lsim(sys2,u2,tp2,x0);
%     X(:,(nos*duty+1+(i-1)*nos:i*nos))=x(2:end,:)';
%     x0=x(end,:);
% end

u1=vin;
u2=vin;

del_t=1/(f*nos);
p1=inv(I-a1*del_t);
q1=p1*b1*del_t;
p2=inv(I-a2*del_t);
q2=p2*b2*del_t;
R=(p1^(nos*duty))*(p2^(nos*(1-duty)));
S=(p2^(nos*(1-duty)))*(I-(p1^(nos*duty)))*inv(I-p1)*(q1);
T=(I-(p2^(nos*(1-duty))))*inv(I-p2)*(q2);

x=zeros(3,10);
for m=1:10
x(:,m)=(p1^m)*x0'+(I-p1^m)*inv(I-p1)*q1*u1;
end
%X=(R^k)*x0'+(I-R^k)*inv(I-R)*(S*u1+T*u2);
disp(x);


% for k=1:n
%     for m=1:nos
%         if(m<)
%     
% end
% 
% time=[0 time];
% X=[[0;0;0] X];
% x1=X(1,:);
% x2=X(2,:);
% x3=X(3,:);

% (x(:,1)-x0')/del_t
% a1*x(:,1)+b1*vin
% 
% inv(I-a1*del_t)*(x0'+b1*del_t*vin)
% (I-a1*del_t)*x(:,1)
% 
% x(:,1)-q1*vin