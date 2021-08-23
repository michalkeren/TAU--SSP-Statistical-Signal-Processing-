function [] = plot_param_est_comp(S_est,Sxx,w,type,lable)
    plot(w,S_est)
    hold on
    plot(w,Sxx,'--black')
    if type=='MA'
        legend('q=2','q=3','q=4','S_x_x')
    else
        legend('p=2','p=3','p=4','S_x_x')
    end
    xlabel('\omega')
    ylabel('Magnitude')
    ax = gca;
    ax.XTick = 0:.5*pi:pi;
    ax.XTickLabel=['  0   ';' \pi/2';' \pi  '];
    title(lable);
    grid on;
end

