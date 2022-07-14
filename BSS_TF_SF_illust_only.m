

function [fidexmult,Xout,Veccc,SigA] = BSS_TF_SF_illust_only(Sig,N_S,win_length, delta,L,step,FFT_len)
%for i=1:num
[Xout,Veccc,~] = BSS_SF(Sig,N_S,win_length);
 figure;
    I=HTFD_new1(Sig(1,:),3,8,64);
    imagesc(reshape(abs(I),128,128))
    set(gcf,'Position',[20 100 640 500]);
    xlabel('Time / Sec','FontSize',30,'FontName','Times New Roman');
    ylabel('Frequency / Hz','FontSize',30,'FontName','Times New Roman');
    set(gca,'YDir','normal');
    set(gca,'FontSize',30);
     figure;
    I=HTFD_new1(Xout,3,8,64);
    imagesc(reshape(abs(I),128,128))
    set(gcf,'Position',[20 100 640 500]);
    xlabel('Time / Sec','FontSize',30,'FontName','Times New Roman');
    ylabel('Frequency / Hz','FontSize',30,'FontName','Times New Roman');
    set(gca,'YDir','normal');
    set(gca,'FontSize',30);
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



