size=6;
R0=zeros(1,size);
F=logspace(3,7,size);
disp(R0);
for q=1:size
    f=F(q);
    SP_ver3;
    R0(q)=Rout;
end

semilogx(F,R0);