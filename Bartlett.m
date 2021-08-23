function [S_BA] = Bartlett(X,K,N,w,D)
    L=N+D*(1-K);
    S_k= zeros(K,length(w));
    start=1-D;
    for k=0:K-1
        start= start+D;
        fin= start+(L-1);
        S_k(k+1,:)= periodogram(X(start:fin),L,w);
    end
    S_BA= 1/K.*sum(S_k,1); 
end

