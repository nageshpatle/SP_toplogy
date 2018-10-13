z0=50;
R=100;
z1=(z0*R)^0.5;

a=pi/(2*1e9);
s11=[];
zin=[];
k=1;
for f=8e9:0.1e9:12e9
zin(k)=z1*(R+(z1*tan(a*f))*1i)/(z1+(R*tan(a*f))*1i);
s11(k)=abs((zin(k)-z0)/(zin(k)+z0));
k=k+1;
end

f=8e9:0.1e9:12e9;
plot(f,s11)