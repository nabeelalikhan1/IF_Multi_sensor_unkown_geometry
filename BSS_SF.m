

function [Xout,Veccc,Sig] = BSS_SF(Sig,N_S,win_length)
% SET OF FRACTIONAL WINDOWS
% Sig=X;
% N_S=N_sensors;
% win_length=65;
% num=n_sources;
% thr=0;
% Thr=0;
% L=8;
% FFT_len=length(X);
% step=4;
%delta
w=gausswin(win_length,1);
%l=0:win_length-1;
%FFT_len1=max(2*N_S,64);
%kl=0:N_S-1;
% for iii=1:FFT_len1
%     W2(iii,:)=exp(-1i*(iii)*2*pi*kl/FFT_len1);
% end
%
% for iii=1:FFT_len
%     WW(iii,:)=exp(-1i*(iii)*2*pi*l/FFT_len);
% end
% e_max=0;
%tic;
i=0;
L=100;
window_rot=zeros(2*L+1,win_length);
for k=-L+1:1:L-1
    i=i+1;
    window_rot(i,:)=frft(w,1* k/L);%0.05
end
%save('window_rot','window_rot');
%load('window_rot');
%toc;
%size(Sig)
Siga=filter(ones(1,win_length),1,sum(abs(Sig)));
% Siga
[~,t_start]=max(Siga(floor(win_length/2)+1:end-floor(win_length/2)));
%t_start
t_start=t_start(1)+floor(win_length/2);
% t_start=46;
v_m=0;
for i=1:2*L+1
    FF=zeros(N_S,length(Sig));
    for jj=1:N_S
        A=(fft(Sig(jj,t_start-floor(win_length/2):t_start+floor(win_length/2)).*window_rot(i,:),1*length(Sig)));
        FF(jj,1:end/2)=A(1:end/2);
    end
    FFd=sum(abs(FF));
    %FFd=abs(fft(FF,FFT_len1));
    v=max(FFd(:));
    [~,index]=find(FFd==max(FFd(:)));
    %index=f(1);
    %f1=f1(1);
    %FF=abs(fft(fft(Sig(:,t_start-floor(win_length/2):t_start+floor(win_length/2)).*window_rot(i,:),length(Sig)));
    
    %[v,index]=max(FF(1:end/2));
    if v_m<v
        Vector=FF(:,index);
        %Vector=Vector/norm(Vector);
        
        %freqS=indexS;
        v_m=v;
    end
end
Vector=Vector.';

A = conj(Vector)/norm(Vector);
%A=conj(Vector)./abs(Vector);
x = (A)*Sig;%/N_S;
Xout=x;

Veccc(1,:)=A;
%figure; 
%I=HTFD_new1(Sig(1,:),3,8,64);
%imagesc(I);
Sig=Sig-(A')*x;%*abs(sum(AA*X)).^2;

%figure; 
%I=HTFD_new1(Sig(1,:),3,8,64);
%imagesc(I);




%A = Vector.';%/norm(Vector);
%x = pinv(A)*Sig;%/N_S;
%Xout=x;

%Veccc(1,:)=A;
%Sig=Sig-(A)*x;%*abs(sum(AA*X)).^2;





end