delete(instrfindall);
seriallist;
instrhwinfo;
s=serial('COM2');
fopen(s);
%fprintf(s,'*IDN?'); %eqv Serial.print


Varr=zeros(500,1);
Iarr=zeros(500,1);
t=1:500;
i=501;

h1=plot(Varr,t);
hold on
h2=plot(Iarr,t);

set(h1,'XDataSource', 't')
set(h1,'YDataSource', 'Varr')
set(h2,'XDataSource', 't')
set(h2,'YDataSource', 'Iarr')
set(gca,'Ylim',[2 8])

tic 
b=toc;
fscanf(s);%redundant bit read

while(toc-b<50)
t(i)=i;
out = fscanf(s,'%f');%eqv Serial.read
Iarr(i)=out;

out = fscanf(s,'%f');%eqv Serial.read
Varr(i)=out;

refreshdata
drawnow
%xlim=([i-500 i]);
%pause(0.000001)
i=i+1;
end
%fprintf/fscanf/read
%fwrite
% https://in.mathworks.com/help/instrument/serial-port-interface.html

