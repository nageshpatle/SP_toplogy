delete(instrfindall);
seriallist;
instrhwinfo;
s=serial('COM18');
fopen(s);
fprintf(s,'*IDN?'); %eqv Serial.print
i=1;
tic 
b=toc;
arr=zeros(500,1);
while(toc-b<20)
out = fscanf(s,'%d');%eqv Serial.read
if(out*1==out)
arr(i)=out;
end
i=i+1;

end
%fprintf/fscanf/read
%fwrite
% https://in.mathworks.com/help/instrument/serial-port-interface.html
plot(arr)
