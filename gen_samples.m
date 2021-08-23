function [X, Sxx] = gen_samples(type)
    N=128;
    b = [1 1.1 0.48 -0.64];
    a = [1 0.4 -0.44 -0.416];

    if type=="MA"
        W= randn(133,1);
        var_W=std(W).^2;
        X = filter(b,1,W);
        X= X(end-(N-1):end); %keep the last 128 samples only.
%         Sxx=var_W*abs(B).^2;
        
    else
        W=randn(1000,1);
        var_W=std(W).^2;
        X = filter(1,a,W);
        X= X(end-(N-1):end);
%         Sxx=var_W*abs(1./A).^2;
    end
end

