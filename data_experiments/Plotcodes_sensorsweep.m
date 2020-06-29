
%%Plot codes 

% load('MSE_ss_ex2')

MSE_ss_m_ex1 =squeeze(MSE_ss_ex1)';
gp_performance = (MSE_ss_m_ex1(:,1) + MSE_ss_m_ex1(:,2))/2;
% ls_performance = (MSE_ss_m_ex1(:,3) + MSE_ss_m_ex1(:,4))/2;
% nu_performance = (MSE_ss_m_ex1(:,5) + MSE_ss_m_ex1(:,6))/2;
x_axis = L;


plot(x_axis,10*log10(gp_performance),'k--')
% hold on
% plot(x_axis,10*log10(ls_performance),'b--')
% hold on
% plot(x_axis,10*log10(nu_performance),'r--')



xlabel('Number of elements')
ylabel('MSE (dB)')
legend('SVR Intp','LS Intp','Non-uniform')

hold off