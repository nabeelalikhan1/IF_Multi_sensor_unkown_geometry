

function [fidexmult,Xout,Veccc,SigA] = BSS_TF_SF(Sig,N_S,win_length, delta,L,step,FFT_len)
%for i=1:num
[Xout,Veccc,~] = BSS_SF(Sig,N_S,win_length);
%Veccc=Veccc./abs(Veccc);
[fidexmult,Xout] = FASTEST_IF(Xout,win_length, 1, delta,L,0,0,step,FFT_len);
%size(Veccc)
%size(Sig)
for i=1:N_S

 %  Veccc(i) =mean(Sig(i,:).*exp(-2*pi*1i*filter(1,[1 -1],fidexmult)));
   
end
%Veccc=conj(Veccc)/norm(Veccc);
SigA=Sig-Veccc'*Xout;

%I=HTFD_new1(Xout,3,8,64);
 %             figure;imagesc(I)
     %         I=HTFD_new1(SigA(1,:),3,8,64);
     %         figure;imagesc(I)

%end

end



