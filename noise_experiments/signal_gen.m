function [X_nu,noise_variance] = signal_gen(positions_x_nu,L,lambda,az_theta,N,noise_var,positions_x_u)

        X_nu = zeros(L,N);
        phi=2*pi*sin(repmat(az_theta,L,1))/lambda;
        K=length(az_theta);
        D=repmat(positions_x_nu',1,K);
        D_u=repmat(positions_x_u',1,K);
        E=exp(1j*phi.*D);
        E_u=exp(1j*phi.*D_u);
        symbols=sign(randn(N,K))+1j*sign(randn(N,K));
        
        for n=1:N
            X_nu(:,n)=sum(repmat(symbols(n,:),L,1).*E,2);
        end
        noise = 1*noise_var*randn(size(X_nu))+1i*noise_var*randn(size(X_nu));
        X_nu=X_nu+noise;
        noise_variance = var(noise(:));
        
        
end 