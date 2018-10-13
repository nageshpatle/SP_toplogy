delete(instrfindall);
seriallist;
instrhwinfo;
s=serial('COM2');
fopen(s);
%fprintf(s,'*IDN?'); %eqv Serial.print

tic 
b=toc;
Varr=zeros(500,1);
Iarr=zeros(500,1);
t=1:500;
i=501;
fscanf(s);%redundant bit read
plot(Varr)
plot(Iarr)
xlim([1 500]);
ylim([2 8]);
grid on

while(toc-b<50)
out = fscanf(s,'%f');%eqv Serial.read
Iarr(i)=out;

out = fscanf(s,'%f');%eqv Serial.read
Varr(i)=out;
hold off
plot(Varr(i-500:end))
hold on
plot(Iarr(i-500:end))
pause(0.000001)
i=i+1;
end
%fprintf/fscanf/read
%fwrite
% https://in.mathworks.com/help/instrument/serial-port-interface.html

