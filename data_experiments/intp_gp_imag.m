function [X_imag_mu,X_imag_var,f_imag_mu,f_imag_var,hyp2,hyp] = intp_gp_imag(l_imag,sf_imag,sn_imag,positions_x_nu,X_imag,positions_x_u,L,N)

positions_x_nu = positions_x_nu';
positions_x_u = positions_x_u';
X_imag_mu = zeros(L,N);
X_imag_var = zeros(L,N);
f_imag_mu = zeros(L,N);
f_imag_var = zeros(L,N);

meanfunc = [];%{@meanSum, {@meanLinear, @meanConst}}; 
covfunc={'covSum',{@covSEiso, @covConst}};

hyp.mean = [];  
hyp.SE= [log(sf_imag);log(l_imag)];%
hyp.const=log(sqrt(1));
hyp.cov=[hyp.SE;hyp.const];
likfunc = @likGauss;
   
hyp.lik = log(sn_imag);
hyp2=hyp;

for i = 1:N
    
hyp2 = minimize(hyp, @gp,-1000,@infGaussLik, meanfunc, covfunc,likfunc, positions_x_nu,X_imag(:,i ));
%exp(hyp2.SE)
[X_imag_mu(:,i),X_imag_var(:,i), f_imag_mu(:,i), f_imag_var(:,i)] = gp(hyp2,@infGaussLik,meanfunc,covfunc,likfunc, positions_x_nu, X_imag(:,i), positions_x_u);%calculating the mean and variance
%nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, positions_x_nu, X_imag(:,i));%calculating negetive log likelihood
end 

% for i=1:N
%     
%     [X_imag_mu(:,i),X_imag_var(:,i), f_imag_mu(:,i), f_imag_var(:,i)] = gp(hyp2, @infLOO,meanfunc, covfunc, likfunc, positions_x_nu, X_imag(:,i), positions_x_u);%calculating the mean and variance
% end 

end 