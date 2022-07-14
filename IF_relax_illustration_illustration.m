clear all;
close all;
N_sensors=128/32;
N_sensors=2;
n=0:127;
%addpath('D:\D\win64_bin\win64_bin');
addpath('E:\tfsa_5-5\windows\win64_bin');
%addpath('E:\Published Papers\DOA estimation of intersecting components 2018\Matlab code');
%addpath('E:\Published Papers\DOA ESTIMATION VITERBI\Multi-sensor IF estimation code');

%crossing componentsi8

s1=1.*exp(2*pi*1i*(0.05*n+0.3*n.^3/(128*128*3)));
%s2=1*exp(2*pi*1i*(0.32*n-0*0.3*n.^3/(128*128*3)));
s3=1.*exp(2*pi*1i*(0.075*n+1*0.3*n.^3/(128*128*3)));
%s3=1.*exp(2*pi*1i*(0.1*n+1*0.3*n.^3/(128*128*3)));

s5=1.*exp(2*pi*1i*(0.46*n-1*0.35*n.^3/(128*128*3)));
SampFreq=128;
FFT_len=128;
perc=0.4;
s = [(s1.') (s3.') (s5.')];%  (s5.') (s6.') (s7.') ];
%s=real(s);
IF_O(1,:)=0.05+0.3*3*n.^2/(128*128*3);

IF_O(3,:)=0.08+1*0.3*3*n.^2/(128*128*3);
IF_O(2,:)=0.46-1*0.35*3*n.^2/(128*128*3);
IF_O=IF_O.';


n_sources=3;
s_orig=s;

LL=500;
index=0;
num=n_sources;




A=exp(1j*pi*2*(rand(N_sensors,n_sources)-0.5));


X = A*s.';
%X=hilbert(X);
SNR=5;% mixed source
% generate noise

sigma = 10^(-SNR/20);
w = sigma*(randn(N_sensors,length(n)) + 1j*(randn(N_sensors,length(n))))/sqrt(2); % noise

X=X+w;



win_length=65;
FFT_len=128;
L=64;
delta=2;
%I=HTFD_new1(Sig(1,:),2,8,64);
 %     figure;
  %   imagesc(I)
    
[ IF1,Xout ] = relax_filtering_TF_SF_new_illust_only( X,n_sources,N_sensors,win_length,delta,L,1,FFT_len,IF_O);
figure
plot(IF_O,'b','linewidth',4);
hold on;
plot(IF1.','r:','linewidth',4)
xlabel('Time (s)','FontSize',30,'FontName','Times New Roman');
ylabel('Frequency(Hz)','FontSize',30,'FontName','Times New Roman');
axis([0 128 0 0.5]);
legend('Original IF','Estimated IF');





% IF estimation using FAST-IF


