function [S] = Cologram(x,w,N,isBaised,BT_L)
    zero= N; %R[0] is at index N=128.
    if isBaised
        R_B= xcorr(x,'biased'); 
    else
        R_B= xcorr(x,'unbiased');
    end
    S=ones(1,length(w)).*R_B(zero);
    if BT_L~=0
        stop= BT_L;
    else
        stop= N-1;
    end
    for l= 1:stop
        S= S +2*cos(w.*l).*R_B(zero+l); %making sure the estimatore is real.
    end
end

