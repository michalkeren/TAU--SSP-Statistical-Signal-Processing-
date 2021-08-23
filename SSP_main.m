close all
clear all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        % PART-1 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%-Q1-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- 1.A: Z domain  --------------
B_z= tf([1, 1.1, 0.48, -0.64],[1,0,0,0]);
B_conj_inv_conj_z = tf([-0.64, 0.48, 1.1, 1],[1]);
S_a_Z = 1*B_z*B_conj_inv_conj_z;
zeros_S_a = zero(S_a_Z);
poles_S_a= pole(S_a_Z);
%---------------------%
A_z= tf([1, 0.4, -0.44, -0.416],[1,0,0,0]);
A_conj_inv_conj_z = tf([-0.416, -0.44, 0.4, 1],[1]);
S_b_Z = 1/(1*A_z*A_conj_inv_conj_z);
zeros_S_b = zero(S_b_Z);
poles_S_b= pole(S_b_Z);
%---------------------%
% figure('name',"1.A");
% subplot(1,2,1)
% pzmap(S_a_Z);
% title("Pole-zero Map of S_a(z)");
% grid on
% subplot(1,2,2)
% pzmap(S_b_Z);
% title("Pole-zero Map of S_b(z)");
% grid on

%---------------------- 1.B: S_xx  ------------------
w=linspace(0,pi,1024);
b = [1 1.1 0.48 -0.64];
a = [1 0.4 -0.44 -0.416];
B=zeros(1,length(w));
A=zeros(1,length(w));
for j=1:4
    B= B +b(1,j).*exp(-j*1i.*w);
    A= A +a(1,j).*exp(-j*1i.*w);
end
Sxx(1,:)= abs(B).^2;
Sxx(2,:)= 1./abs(A).^2;

% figure('name',"Q1.B");
% for j=1:2
%     subplot(1,2,j)
%     plot(w,Sxx(j,:))
%     xlabel('\omega')
%     ylabel('Magnitude')
%     ax = gca;
%     ax.XTick = 0:.5*pi:pi;
%     ax.XTickLabel=['  0   ';' \pi/2';' \pi  '];
%     if j==1
%         title('for X_a[n]');
%     else
%         title('for X_b[n]');
%     end
%     sgtitle("S_x_x(e^j^w)");
% end

%%%%%%%%%%%%%%%%%%%%%%%%%-Q2-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=128;
X_a = gen_samples("MA");
X_b = gen_samples("AR");
X= [X_a X_b];
% figure('name',"Q2");
% subplot(2,1,1)
% stem(X_a);
% xlim([0 130])
% xlabel('X_a[n]')
% subplot(2,1,2)
% stem(X_b);
% xlim([0 130])
% xlabel('X_b[n]')
% sgtitle('128 samples of X_a[n] & X_b[n]');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        % PART-2 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%-Q3-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:2
    x= X(:,i);
    %3.A- Cologram Estimator:
    S_B(i,:)= Cologram(x,w,N,1,0);
    %3.B-Periodegram Estimator:
    S_P(i,:)=periodogram(x,N,w);
    %3.D- not Baised corlogram:
    S_cor(i,:)= Cologram(x,w,N,0,0);
end
% figure('name',"Q3.A");
% plot_Spec(S_B,w,"S_B(e^j^w)")
% figure('name',"Q3.B");
% plot_Spec(S_P,w,"S_P(e^j^w)")
%3.C
%figure('name',"Q3.c");
%plot_comparison(w,S_B,S_P,Sxx,0)
% figure('name',"Q3.D");
% plot_comparison(w,S_B,S_P,Sxx,S_cor)

%%%%%%%%%%%%%%%%%%%%%%%%%-Q4-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data_a= zeros(7,3);
Data_b= zeros(7,3);
% %A- periodegram
% disp("---periodegram---")
% [Data_a(1,:), Data_b(1,:)]=eval_nonparam_est('periodegram',Sxx ,N,w,0,0,0,"periodegram");
% % %B- Bartlett K=4
% disp("---Bartlett K=4---")
% K=4;
% [Data_a(2,:), Data_b(2,:)]= eval_nonparam_est("Bartlett",Sxx,N,w,K,0,0,"Bartlett K=4");
% % %C- Bartlett K=8
% disp("---Bartlett K=8---")
% K=8;
% [Data_a(3,:), Data_b(3,:)]=eval_nonparam_est("Bartlett",Sxx,N,w,K,0,0,"Bartlett K=8");
% % %D- Welsh 
% disp("---Welsh K=7,D=16---")
% K=7;
% D=16;
% [Data_a(4,:), Data_b(4,:)]=eval_nonparam_est("Welsh",Sxx,N,w,K,D,0,"Welsh K=7,D=16");
% % %E- Welsh 
% disp("---Welsh K=15,D=8---")
% K=15;
% D=8;
% [Data_a(5,:), Data_b(5,:)]=eval_nonparam_est("Welsh",Sxx,N,w,K,D,0,"Welsh K=15,D=8");
% % %F- BT
% disp("---BT L=4---")
% L=4;
% [Data_a(6,:), Data_b(6,:)]=eval_nonparam_est("BT",Sxx,N,w,K,0,L,"BT L=4");
% %G- BT
% disp("---BT L=2---")
% L=2;
% [Data_a(7,:), Data_b(7,:)]=eval_nonparam_est("BT",Sxx,N,w,0,0,L,"BT L=2");

%%%%%%%%%%%%%%%%%%%%%%%%%-Q5-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%save stats into CSV:
% writematrix(Data_a,'Q5_Xa.csv')
% writematrix(Data_b,'Q5_Xb.csv')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        % PART-3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%-Q6-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X_a = gen_samples("MA");
X_b = gen_samples("AR");
X= [X_a X_b];
%Q.6.a- MA(q)

% figure('name',"Q6.a");
for j=1:2
    S_MA=zeros(3,length(w));
    x= X(:,j);
    for i=1:3
        q=i+1;
        S_MA(i,:)=Cologram(x,w,N,0,q); %the zero indicates non-naised.
    end
%     subplot(1,2,j)
%     sgtitle('Fitting MA(q) models')
%     if j==1
%         lable= ' to X_a[n]';
%     else
%         lable= ' to X_b[n]';
%     end
%     plot_param_est_comp(S_MA,Sxx(1,:),w,'MA',lable)
end


%plot_param_est_comp(S_a,Sxx(1,:),w,'MA','Fitting MA(q) models to X_a[n]')

%Q.6.b- AR(p)
% figure('name',"Q6.b");
for j=1:2
    x= X(:,j);
    S_AR=zeros(3,length(w));
    for i=1:3
        p=i+1;
        S_AR(i,:)=AR_param_estimator(xcorr(x,'unbiased'),p,w);
    end
%     subplot(1,2,j)
%     sgtitle('Fitting AR(p) models')
%     if j==1
%         lable= ' to X_a[n]';
%     else
%         lable= ' to X_b[n]';
%     end
%     plot_param_est_comp(S_AR,Sxx(1,:),w,'AR',lable)
end

%%%%%%%%%%%%%%%%%%%%%%%%%-Q7-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data_a= zeros(6,3);
% Data_b= zeros(6,3);
% d_idx=1;
% for i=1:3
%     order=i+1;
%     [Data_a(d_idx,:), Data_b(d_idx,:)]= eval_param_est("MA",order,Sxx,N,w,"Fitting MA("+ num2str(order)+") models");
%     [Data_a(d_idx+3,:), Data_b(d_idx+3,:)]= eval_param_est("AR",order,Sxx,N,w,"Fitting AR("+ num2str(order)+") models");
%     d_idx=d_idx+1;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%-Q8-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%save stats into CSV:
% writematrix(Data_a,'Q8_Xa.csv')
% writematrix(Data_b,'Q8_Xb.csv')

%%%%%%%%%%%%%%%%%%%%%%%%-fin-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

