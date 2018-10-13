L=1.6e-6;
C=10e-9;
R=50;

syms s t
i(s)=(L/(R+s*L+(1/(s*C))));
i(t)=ilaplace(i(s));

a=1e-9;
T=50;

y=zeros(T,1);

for t=1:T
    y(t)=double(i(t/a));
end

time=1:T;
plot(y,t,'o');
