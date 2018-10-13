Rsw=1;
Cfly_curr=1e-5;
Cfly_old=0.5e-5;
f_curr=1e4;
f_old=1.5e4;
alpha=1e-7;
beta=1;
ITR=10;
J_old=0;


for itr=1:ITR
J_curr=Costfunction(Rsw,Cfly_curr,f_curr);   
Cfly_new=Cfly_curr-alpha*(J_curr-J_old)/(Cfly_curr-Cfly_old);
f_new=f_curr-beta*(J_curr-J_old)/(f_curr-f_old);


Cfly_old=Cfly_curr;
f_old=f_curr;
J_old=J_curr;

Cfly_curr=Cfly_new;
f_curr=f_new;
end

disp([f_curr Cfly_curr]);