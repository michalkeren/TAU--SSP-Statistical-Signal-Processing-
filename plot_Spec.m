function [] = plot_Spec(S,w,lable)
    for i=1:2
        subplot(1,2,i)
        plot(w,S(i,:))
        xlabel('\omega')
        ylabel('Magnitude')
        ax = gca;
        ax.XTick = 0:.5*pi:pi;
        ax.XTickLabel=['  0   ';' \pi/2';' \pi  '];
        if i==1
            title('for X_a[n]');
        else
            title('for X_b[n]');
        end
        sgtitle(lable);
    end
end

