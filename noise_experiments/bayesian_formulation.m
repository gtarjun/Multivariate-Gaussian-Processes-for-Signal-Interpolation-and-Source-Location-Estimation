%% Runing script GP interpolation
%addpath(genpath('L:\Gaussian Process Formulation\gpml-matlab-v4.2-2018-06-11\'))
%addpath('/users/ceodspsp/CARC_Work/User_support/Arjun/Working_Folder/')
addpath('/users/ceodspsp/CARC_Work/User_support/Arjun/Working_Folder/gpml-matlab-v4.2-2018-06-11')
rng('shuffle')
rng('shuffle')
%% Runing script SVR vs LS interpolation
startup
az_theta=[10 30]*pi/180; %DOA’s of signals in rad.
az_theta_D = az_theta*180/pi;
P=[1 1 1]; %Incoming signal power
N= 200; %Number of data points
lambda = 2;%Wavelength
d= 0.5*lambda; %Distance between elements in wavelength
noise_var= 10^(params(1)/10); %Variance of noise
m=length(az_theta); %Number of emitter sources
search_angles=(-90:1:90); %Azimuth search vector
deviation= 5;%Deviation coefficient 
iterations=2000;%Number of runs per sweep 
L=10;%number of sensors

squared_error=zeros(1,5*m,iterations);
sn_imag_opt=zeros(iterations,1);
sn_real_opt=zeros(iterations,1);
sf_imag_opt=zeros(iterations,1);
l_imag_opt=zeros(iterations,1);
sf_real_opt=zeros(iterations,1);
l_real_opt=zeros(iterations,1);

%GP solution
%1.2 1.2 0.1 0.1 best so far for L=15
%0.8,0.8,0.01,0.01 best for L =8
sf_imag=1.1;
sf_real=1.1;
l_real=1.1;
sn_real=0.12;
sn_imag=0.12;
l_imag=1.1;
counter=0;

%in_data=zeros(1,2,iterations);
 
for i=1:iterations
    

[positions_x_nu,positions_x_u] = sensor_locations(d,deviation,L); %fetching positions 
[X_nu,noise_variance] = signal_gen(positions_x_nu,L,lambda,az_theta,N,noise_var,positions_x_u);%fetching signal and noise variance
%in_data(:,:,i)=[X_nu.noise_variance];
X_real = real(X_nu);%Real part of X
X_imag = imag(X_nu);%Imaginary Part of X

[X_imag_mu,X_imag_var,f_imag_mu,f_imag_var,hyp2,hyp] = intp_gp_imag(l_imag,sf_imag,sn_imag,positions_x_nu,X_imag,positions_x_u,L,N); %GP solution for the imaginary part

[X_real_mu,X_real_var,f_real_mu,f_real_var,hyp3,hyp1] = intp_gp_real(l_real,sf_real,sn_real,positions_x_nu,X_real,positions_x_u,L,N,X_imag,X_imag_mu); %GP solution for the real part

X_estimated = X_real_mu + 1i*X_imag_mu; %Estimated uniformly sampled signal
X_estimated = reshape(X_estimated,size(X_nu,1),size(X_nu,2));

DOA_nu= sort(2*(180*asin((rootmusic(X_nu*X_nu',2))/2/pi/d)/pi))';%nonuniform sampling
DOA_gp= sort(2*(180*asin((rootmusic(X_estimated*X_estimated',2))/2/pi/d)/pi))';%GP interpolated
DOA_ls= LS_intp(N,lambda,positions_x_nu,d,X_nu,positions_x_u,m,noise_variance,L);%LS interpolated 
DOA_ls45= LS_intp45(N,lambda,positions_x_nu,d,X_nu,positions_x_u,m,noise_variance,L);%LS interpolated
DOA_ls60= LS_intp60(N,lambda,positions_x_nu,d,X_nu,positions_x_u,m,noise_variance,L);%LS interpolated

data_matrix_ss=[DOA_gp DOA_ls DOA_ls45 DOA_ls60 DOA_nu];
squared_error(:,:,i)=(data_matrix_ss-[sort(az_theta_D) sort(az_theta_D) sort(az_theta_D) sort(az_theta_D) sort(az_theta_D)]).^2;

% sn_imag_opt(i)=exp(hyp2.lik);
% sn_real_opt(i)=exp(hyp3.lik);
% sf_imag_opt(i)=exp(hyp2.SE(1));
% l_imag_opt(i)=exp(hyp2.SE(2));
% sf_real_opt(i)=exp(hyp3.SE(1));
% l_real_opt(i)=exp(hyp3.SE(2));

% sn_imag_opt(i)
% sn_real_opt(i)
% sf_imag_opt(i)
% l_imag_opt(i)
% sf_real_opt(i)
% l_real_opt(i)
end
MSE_ss=mean(squared_error,3);

%MSE=mean(mean(squared_error,2),3);
data_look=[params(1),MSE_ss];
%signalwatch=[index,in_data];
dlmwrite('gp_noisesweep_rev.csv',data_look,'delimiter',',','-append')
%dlmwrite('signal_watch.csv',signalwatch,'delimiter',',','-append')
