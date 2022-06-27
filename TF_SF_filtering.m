
function [x,Sig] = TF_SF_filtering(Sig,IF,N_S,A,LL)

Phase=2*pi*filter(1,[1 -1],IF);
    s_dechirp=exp(-1i*Phase);
    
    
   % LL=delta;
    %TF filtering for each sensor
    ssss=0;
    for jj=1:N_S
        
        s1 = Sig(jj,:).*(s_dechirp);
        s2=fftshift(fft(s1));
        %  e_max
        
        ssss=ssss+sum(abs(s2(length(Sig)/2-LL-1:length(Sig)/2+LL-1).^2));
        % Energy of the last component
        s1=zeros(size(s2));
        s1(length(Sig)/2-LL:length(Sig)/2+LL)=s2(length(Sig)/2-LL:length(Sig)/2+LL);
        s2(length(Sig)/2-LL:length(Sig)/2+LL)=0;
        
        s1=ifft(ifftshift(s1)).*conj(s_dechirp);
        s2=ifft(ifftshift(s2)).*conj(s_dechirp);
        
        
                [s1,~,~] = ICCD_sparse(Sig(jj,:),1,IF,3,1,1:length(Sig));

        %wo=asind((ww-1)/64);
        Xout1(jj,:)=s1;
        
    %    Sig(jj,:)=s2;%-extr_Sig(iii);
 %       Xout(jj,:)=s1;
        % end
    end
    %A = conj(Vector)/norm(Vector);
%A=conj(A);
   x = (A)*Xout1;%/N_S;
   Sig=Sig-(A')*x;%*abs(sum(AA*X)).^2;
   %I=HTFD_new1(s1,3,8,64);
   %figure; imagesc(I)
  % Sig=Sig-pinv(A)*x;%*abs(sum(AA*X)).^2;
   
  % x=pinv(A.')*Xout1;
   
   %Sig=Sig-A.'*x;
   
   %x = A*Xout1;%/N_S;
  % Sig=Sig-pinv(A)*x;%*abs(sum(AA*X)).^2;
   
   
end



