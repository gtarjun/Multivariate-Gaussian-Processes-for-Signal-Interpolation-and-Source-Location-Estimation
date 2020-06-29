function DOA_nu = nonuniform_DOA(X_nu,N,m,d)
% Rxx_nu = X_nu*X_nu'/N;
% DOA_nu = sort(rootmusicdoa(Rxx_nu,m));
DOA_nu = sort(2*(180*asin((rootmusic(X_nu*X_nu',2))/2/pi/d)/pi))';
end 