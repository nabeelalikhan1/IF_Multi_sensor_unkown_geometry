clear all;
close all;
N_sensors=16;
n=0:127;

s1=1.*exp(2*pi*1i*(0.05*n+0.3*n.^3/(128*128*3)));
%s2=1*exp(2*pi*1i*(0.32*n-0*0.3*n.^3/(128*128*3)));
s3=1.*exp(2*pi*1i*(0.09*n+1*0.3*n.^3/(128*128*3)));

s4=1.*exp(2*pi*1i*(0.48*n-0.35*n.^3/(128*128*3)));
s2=1.*exp(2*pi*1i*(0.35*n+0.3*n.^2/(128*8)));
s5=1.*exp(2*pi*1i*(0.43*n-1*0.35*n.^3/(128*128*3)));
SampFreq=128;
FFT_len=128;
perc=0.4;
s = [(s1.') (s2.') (s3.') (s4.') (s5.')];%  (s5.') (s6.') (s7.') ];
%s=real(s);
IF_O(1,:)=0.05+0.3*3*n.^2/(128*128*3);
IF_O(2,:)=0.35+1*0.3*2*n.^1/(128*8);
IF_O(3,:)=0.09+1*0.3*3*n.^2/(128*128*3);
IF_O(4,:)=0.43-1*0.35*3*n.^2/(128*128*3);
IF_O(5,:)=0.48-3*0.35*n.^2/(128*3*128);
IF_O=IF_O.';
win_length=65;
L=32;

n_sources=7-2;
s_orig=s;

%LL=500;
LL=10;
index=0;
delta=1;
num=n_sources;
for SNR=-10:5:10
    %for SNR=-2:2:0
    for ii=1:LL
        
        
        %A = exp(1j*pi*[0:N_sensors-1].'*sin(theta));  % mixing matrix A
        A=exp(1j*pi*2*(rand(N_sensors,5)-0.5));

        
        X = A*s.';                             % mixed source
        % generate noise
        
        sigma = 10^(-SNR/20);
        w = sigma*(randn(N_sensors,length(n)) + 1j*(randn(N_sensors,length(n))))/sqrt(2); % noise
        
        X=X+w;
        
        
        %tic
        for k=0:2
            
            switch k
                case 0
                    [ IFF,~ ] = relax_filtering_TF_SF_new( X,n_sources,N_sensors,win_length,delta,L,1,FFT_len );
                    
                case 1
                    
                    %[IFF,ss] = Multi_Sensor_FASTEST_IF_new(X,N_sensors,65, n_sources, delta,64,0,0,4,length(X));
                    [ IFF,~ ] = TF_SF_BSS( X,n_sources,N_sensors,win_length,delta,L,1,FFT_len );
                case 2
                    [IFF,~] = Multi_Sensor_FASTEST_IF(X,N_sensors,65, n_sources, delta,L,0,0,1,length(X));
                    
            end
            
            
            
            %toc
            
            
            msee=0.1*ones(1,num);
            
            for ii22=1:num
                
                t=1:128;
                IF=IFF(ii22,:);%/length(X);
                t=t(5:end-5);
                for i=1:num
                    c(i)=sum(abs(IF(t)'-IF_O(t,i)).^2);
                end
                [a1, b1]=min(c);
                if msee(b1)>=a1(1)/length(X)
                    msee(b1)=a1(1)/length(X);
                end
                
            end
            
            switch k
                case 0
                    mseeIF_refined(ii)=mean(msee);
                case 1
                    mseeIF_new(ii)=mean(msee);
                case 2
                    mseeIF_old(ii)=mean(msee);
                    
            end
            
        end
    end
    index=index+1;
    %mean(mmssee)
    snr_mse_refined(index)=mean(mseeIF_refined)
    snr_mse_new(index)=mean(mseeIF_new)
    
    snr_mse_old(index)=mean(mseeIF_old)
    
    
    
end

SNR=-10:5:10;
plot(SNR,10*(log10(snr_mse_refined)),'--md','linewidth',2);
hold on;
plot(SNR,10*(log10(snr_mse_new)),'r','linewidth',3);
hold on;
plot(SNR,10*(log10(snr_mse_old)),'k','linewidth',3);

xlabel('Signal to Noise Ratio');
ylabel('Mean Square Error (dB)');
legend('Refined IF-estimation using 2-stage method','Coarse IF Estimation using Single Stage','IF estimation using FAST-IF');
%legend('The Proposed Method','Time-frequency Music','DOA based on IF estimation using ridge tracking');

