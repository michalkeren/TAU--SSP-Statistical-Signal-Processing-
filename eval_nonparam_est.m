function [data1,data2] = eval_nonparam_est(estimator,S,N,w,K,D,L,lable)
    figure('name',"Q4");
    M=1000;
    S_est= zeros(M,length(w));
    for j=1:2
        Sxx=S(j,:);
        for i=1:M
            if j==1
                x= gen_samples("MA");
            else
                x= gen_samples("AR");
            end
            if estimator == "periodegram"
                S_est(i,:)= periodogram(x,N,w);
            elseif estimator == "Bartlett"
                S_est(i,:)= Bartlett(x,K,N,w,N/K);
            elseif estimator == "Welsh"
                S_est(i,:)= Bartlett(x,K,N,w,D);
            else %Blackman_Tukey
                S_est(i,:)=Cologram(x,w,N,1,L);
            end
        end
        [avg,bais,std,RMSE,B,V,MSE]= get_impiric_stats(S_est,Sxx,M);
        if j==1
            data1=[B V MSE];
        else
            data2=[B V MSE];
        end
        subplot(1,2,j)
        plot(w,bais,'b')
        hold on
        plot(w,std,'r')
        hold on
        plot(w,RMSE)   
        hold on
        plot(w,Sxx,'--black') 
        hold on
        legend('bais', 'std', 'RMSE','S_x_x')
        if j==1
            title('for X_a[n] (MA)');
        else
            title('for X_b[n] (AR)');
        end
        sgtitle(lable);
        xlabel('\omega')
        ylabel('Magnitude')
        ax = gca;
        ax.XTick = 0:.5*pi:pi;
        ax.XTickLabel=['  0   ';' \pi/2';' \pi  '];
        grid on;
    end
end

