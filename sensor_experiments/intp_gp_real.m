function [X_real_mu,X_real_var,f_real_mu,f_real_var,hyp3,hyp1] = intp_gp_real(l_real,sf_real,sn_real,positions_x_nu,X_real,positions_x_u,L,N,X_imag,X_imag_mu)

positions_x_nu = positions_x_nu';
positions_x_u = positions_x_u';
X_real_mu = zeros(L,N);
X_real_var = zeros(L,N);
f_real_mu = zeros(L,N);
f_real_var = zeros(L,N);

meanfunc = []; 
covfunc={'covSum',{@covSEiso, @covConst}};


hyp1.mean = [];  
hyp1.SE= [log(sf_real);log(l_real)];
hyp1.const=log(sqrt(1));
hyp1.cov=[hyp1.SE;hyp1.const];
likfunc = @likGauss;
   
hyp1.lik = log(sn_real);
hyp3=hyp1;

for i = 1:N

training_matrix = [positions_x_nu X_imag(:,i)];
    
hyp3 = minimize(hyp1, @gp,-1000, @infGaussLik,meanfunc, covfunc, likfunc, training_matrix,X_real(:,i));
test_matrix = [positions_x_u X_imag_mu(:,i)];   
[X_real_mu(:,i),X_real_var(:,i), f_real_mu(:,i), f_real_var(:,i)] = gp(hyp3,@infGaussLik,meanfunc, covfunc, likfunc,training_matrix, X_real(:,i), test_matrix);%calculating the mean and variance

%nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, positions_x_nu, X_real(:,i));%calculating negetive log likelihood

end 

% for i=1:N
%     
% test_matrix = [positions_x_u X_imag_mu(:,i)];   
% [X_real_mu(:,i),X_real_var(:,i), f_real_mu(:,i), f_real_var(:,i)] = gp(hyp3(i), @infLOO,meanfunc, covfunc, likfunc,training_matrix, X_real(:,i), test_matrix);%calculating the mean and variance
% 
% end 

end 
