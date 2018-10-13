delete(instrfindall);
seriallist;
instrhwinfo;
s=serial('COM2');
fopen(s);

%fprintf(s,'*IDN?'); %eqv Serial.print
tic 
b=toc;

while(toc-b<50)
fwrite(s,1);
pause(3);
fwrite(s,0);
pause(3);

end
