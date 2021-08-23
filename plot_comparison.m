function [] = plot_comparison(w,S_B,S_P,Sxx,S_cor)
    for i=1:2 
        subplot(1,2,i)
        plot(w,S_B(i,:),'b') 
        hold on
        plot(w,S_P(i,:),'r')
        hold on
        plot(w,Sxx(i,:),'--black')
        if S_cor ~= 0
            hold on
            plot(w,S_cor(i,:))   
            legend('baised correlogram', 'periodogram', 'true spectrum', 'non-baised correlogram')
        else
            legend('baised correlogram', 'periodogram', 'true spectrum')
        end
        if i==1
            title('for X_a[n]');
        else
            title('for X_b[n]');
        end
        xlabel('\omega')
        ylabel('Magnitude')
        ax = gca;
        ax.XTick = 0:.5*pi:pi;
        ax.XTickLabel=['  0   ';' \pi/2';' \pi  '];
    end
end

