function [ IF,Xout ] = TF_SF_BSS( X,n_sources,N_sensors,win_length,delta,L,step,FFT_len )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Sig=X;

%[IF,Xout(1,:),Veccc(1,:),Sig] = BSS_TF_SF(Sig,N_sensors,win_length, delta,L,step,FFT_len);

%size(Sig)
for MM=1:n_sources
    [IF(MM,:),Xout(MM,:),Veccc(MM,:),Sig] = BSS_TF_SF(Sig,N_sensors,win_length, delta,L,step,FFT_len);

end


end

