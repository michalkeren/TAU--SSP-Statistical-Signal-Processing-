function [avg,bais,std,RMSE,B_sqrd,V,MSE] = get_impiric_stats(S_est,S,M)
    avg= sum(S_est)./M;
    bais= avg-S;
    std=(sum((S_est-avg).^2./M,1)).^0.5;
    Err=S_est-S;
    RMSE= (sum(Err.^2,1)./M).^0.5;
    test= (std.^2+bais.^2).^0.5;
    %----
    B_sqrd = 2/2048*sum(bais.^2);
    V= 2/2048*sum(std);
    MSE=2/2048*sum(RMSE);
end

