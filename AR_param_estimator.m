function [S_est,sigma_w_sqrd,a] = AR_param_estimator(Rxx,p,w)
    a= zeros(p+1,1);
    R=zeros(p,p);
    zero=int16(length(Rxx)/2);         
    r=Rxx(zero+1:zero+p);     
    %---a (Y-W) ---
    for row=1:p                 %fill the R matrix.
        start= zero-(row-1);
        stop=start+(p-1);
        R(row,:)=Rxx(start:stop);
    end
    a(1)=1;
    a(2:end)= -inv(R)*r;
    %---A---
    A=ones(1,length(w));
    for j=1:p
        A= A +a(j+1,1).*exp(-j*1i.*w);
    end
    %---sigma_w^2---
    sigma_w_sqrd=dot(a,Rxx(zero:zero+p));
    %---S_est---
    S_est= sigma_w_sqrd./(abs(A).^2);
end

