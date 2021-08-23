function [S_p] = periodogram(x,N,w)
    %step 1:
    X_k= zeros(1,1024);
    for n=0:N-1
        X_k= X_k+ x(n+1).*exp(-1i.*w.*n);
    end
    %step 2:
    S_p= 1/N.*abs(X_k).^2;
end
