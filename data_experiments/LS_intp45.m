function [DOA_ls45] = LS_intp45(N,lambda,positions_x_nu,d,X_nu,positions_x_u,m,noise_variance,L,noise_vari)

%Search Sectors

search_angles_sector_1 = -90:1:-45;%Search vector sector 1
search_angles_sector_2 = -44:1:0;%Search vector sector 2
search_angles_sector_3 = 1:1:45;%Search vector sector 3
search_angles_sector_4 = 46:1:90;

%Non-uniform steering vectors for respective search sector

a_theta_sector1_nu = exp(1i*2*pi/lambda*d*(positions_x_nu)'*sin(search_angles_sector_1(:).'*pi/180));%Non-uniform steering vectors sector 1
a_theta_sector2_nu = exp(1i*2*pi/lambda*d*(positions_x_nu)'*sin(search_angles_sector_2(:).'*pi/180));%Non-uniform steering vectors sector 2
a_theta_sector3_nu = exp(1i*2*pi/lambda*d*(positions_x_nu)'*sin(search_angles_sector_3(:).'*pi/180));%Non-uniform steering vectors sector 3
a_theta_sector4_nu = exp(1i*2*pi/lambda*d*(positions_x_nu)'*sin(search_angles_sector_4(:).'*pi/180));%Non-uniform steering vectors sector 3

%Uniform steering vectors for respective search sectors

a_theta_sector1_u = exp(1i*2*pi/lambda*d*(positions_x_u)'*sin(search_angles_sector_1(:).'*pi/180));%Uniform steering vectors sector 1
a_theta_sector2_u = exp(1i*2*pi/lambda*d*(positions_x_u)'*sin(search_angles_sector_2(:).'*pi/180));%Uniform steering vectors sector 2
a_theta_sector3_u = exp(1i*2*pi/lambda*d*(positions_x_u)'*sin(search_angles_sector_3(:).'*pi/180));%Uniform steering vectors sector 3
a_theta_sector4_u = exp(1i*2*pi/lambda*d*(positions_x_u)'*sin(search_angles_sector_4(:).'*pi/180));%Uniform steering vectors sector 3

%Interpolation

B_sector1 = a_theta_sector1_u * a_theta_sector1_nu.' /((a_theta_sector1_nu * a_theta_sector1_nu.')+ (noise_variance*eye(L))); %Interpolation matrix sector 1
B_sector2 = a_theta_sector2_u * a_theta_sector2_nu.' /((a_theta_sector2_nu * a_theta_sector2_nu.')+ (noise_variance*eye(L))); %Interpolation matrix sector 2
B_sector3 = a_theta_sector3_u * a_theta_sector3_nu.' /((a_theta_sector3_nu * a_theta_sector3_nu.')+ (noise_variance*eye(L)));%Interpolation matrix sector 3
B_sector4 = a_theta_sector4_u * a_theta_sector4_nu.' /((a_theta_sector4_nu * a_theta_sector4_nu.')+ (noise_variance*eye(L)));%Interpolation matrix sector 3

%Interpolated Signals
 X_i_s1 = B_sector1*X_nu;
 X_i_s2 = B_sector2*X_nu;
 X_i_s3 = B_sector3*X_nu;
 X_i_s4 = B_sector4*X_nu;




% for n=1:N
%     X_u(:,n)=sum(repmat(symbols(n,:),L,1).*E_u,2);
% end
% 
% X_u = X_u+1*noise_var*randn(size(X_u));

%Covariance matrices for rootmusic 

% Rxx = X_u*X_u'/N;
% Rxx_i_s1 = X_i_s1*X_i_s1'/N;
% Rxx_i_s2 = X_i_s2*X_i_s2'/N
% Rxx_i_s3 = X_i_s3*X_i_s3'/N
% Rxx_i_s4 = X_i_s4*X_i_s4'/N
% Rxx_i_s5 = X_i_s5*X_i_s5'/N
% Rxx_i_s6 = X_i_s6*X_i_s6'/N
% Rxx_nu = X_nu*X_nu'/N;

%Rootmusic 

% DOA_uniform = sort(rootmusicdoa(Rxx,m));
% DOA_nonuniform = sort(rootmusicdoa(Rxx_nu,m));
% DOA_sector1 = sort(rootmusicdoa(Rxx_i_s1,m));
% DOA_sector2 = sort(rootmusicdoa(Rxx_i_s2,m));
% DOA_sector3 = sort(rootmusicdoa(Rxx_i_s3,m));
% DOA_sector4 = sort(rootmusicdoa(Rxx_i_s4,m));
% DOA_sector5 = sort(rootmusicdoa(Rxx_i_s5,m));
% DOA_sector6 = sort(rootmusicdoa(Rxx_i_s6,m));

DOA_sector3= sort(2*(180*asin((rootmusic(X_i_s3*X_i_s3',2))/2/pi/d)/pi));
         

%Decision logic for DOA estimations using LS


% if    DOA_sector1(1,1) >= -90 && DOA_sector1(1,1) <= -60 
%       DOA_Friedlander(1,1) = DOA_sector1(1,1);
%          
% elseif DOA_sector2(1,1) >= -59 && DOA_sector2(1,1) <= -30
%        DOA_Freidlander(1,1) = DOA_sector2(1,1);
%         
% elseif DOA_sector3(1,1) >= -29 && DOA_sector3(1,1) <= 0
%         DOA_Freidlander(1,1) = DOA_sector3(1,1);
%             
% elseif DOA_sector4(1,1) >= 1 && DOA_sector4(1,1) <= 30
%        DOA_Freidlander(1,1) = DOA_sector4(1,1);
%                 
% elseif DOA_sector5(1,1) >= 31 && DOA_sector5(1,1) <= 60
%        DOA_Freidlander(1,1) = DOA_sector5(1,1);
%                          
% elseif DOA_sector6(1,1) >= 61 && DOA_sector6(1,1) <= 90
%        DOA_Freidlander(1,1) = DOA_sector6(1,1);
%        
% else
%      DOA_Freidlander(1,1) = DOA_sector4(1,1);
% end
% 
% if    DOA_sector1(1,2) >= -90 && DOA_sector1(1,2) <= -60
%       DOA_Friedlander(1,2) = DOA_sector1(1,2);
%          
% elseif DOA_sector2(1,2) >= -59 && DOA_sector2(1,2) <= -30
%        DOA_Freidlander(1,2) = DOA_sector2(1,2);
%         
% elseif DOA_sector3(1,2) >= -29 && DOA_sector3(1,2) <= 0
%         DOA_Freidlander(1,2) = DOA_sector3(1,2);
%             
% elseif DOA_sector4(1,2) >= 1 && DOA_sector4(1,2) <= 30
%        DOA_Freidlander(1,2) = DOA_sector4(1,2);
%                 
% elseif DOA_sector5(1,2) >= 31 && DOA_sector5(1,2) <= 60
%        DOA_Freidlander(1,2) = DOA_sector5(1,2);
%                          
% elseif DOA_sector6(1,2) >= 61 && DOA_sector6(1,2) <= 90
%        DOA_Freidlander(1,2) = DOA_sector6(1,2);
%        
% else
%       DOA_Freidlander(1,2) = DOA_sector4(1,2);
% end

DOA_ls45 = DOA_sector3';
end
