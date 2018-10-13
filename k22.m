delete(instrfindall);
seriallist;
instrhwinfo;
s=serial('COM18');
s.BaudRate=115200;
fopen(s);
disp("reset now");
pause(10);
disp("resumes");
%fprintf(s,'*IDN?'); %eqv Serial.print
tic
b=toc;
while(toc-b<5)
out = fscanf(s);
disp(out)
end