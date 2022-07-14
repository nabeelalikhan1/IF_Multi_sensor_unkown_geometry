function [ IF,Xout ] = relax_filtering_TF_SF_new_illust_only( X,n_sources,N_sensors,win_length,delta,L,step,FFT_len,IF_O )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Sig=X;
for i=1:n_sources
    figure;
    I=HTFD_new1(Sig(1,:),3,8,64);
    imagesc(reshape(abs(I),128,128))
    set(gcf,'Position',[20 100 640 500]);
    xlabel('Time / Sec','FontSize',30,'FontName','Times New Roman');
    ylabel('Frequency / Hz','FontSize',30,'FontName','Times New Roman');
    set(gca,'YDir','normal');
    set(gca,'FontSize',30);
    
    [IF(i,:),Xout(i,:),Veccc(i,:),Sig] = BSS_TF_SF(Sig,N_sensors,win_length, delta,L,step,FFT_len);
    
    
end
figure
plot(IF_O,'b','linewidth',4);
hold on;
plot(IF.','r:','linewidth',4)
xlabel('Time (s)','FontSize',30,'FontName','Times New Roman');
ylabel('Frequency(Hz)','FontSize',30,'FontName','Times New Roman');
axis([0 128 0 0.5]);
legend('Original IF','Estimated IF');

%Veccc1=Veccc;
for i2=1:5
    % IF=IF1;
    %   Veccc=Veccc1;
    
    for i=1:n_sources
        Sig=X;
        for j=1:n_sources
            
            
            if i~=j   % REmove all components except i-th
                [x,~] = TF_SF_filtering(X,IF(j,:),N_sensors,Veccc(j,:),2);
                Sig=Sig-(Veccc(j,:))'*x;
                %[Sig] = TF_SF_filtering_new(Sig,Xout(i,:),Veccc(j,:));
                
            end
            
            
        end
        if i2==5
        figure;
        I=HTFD_new1(Sig(1,:),3,8,64);
        imagesc(reshape(abs(I),128,128))
        set(gcf,'Position',[20 100 640 500]);
        xlabel('Time / Sec','FontSize',30,'FontName','Times New Roman');
        ylabel('Frequency / Hz','FontSize',30,'FontName','Times New Roman');
        set(gca,'YDir','normal');
        set(gca,'FontSize',30);
        % Restimate i-th component
        [IF(i,:),Xout(i,:),Veccc(i,:),Sig] = BSS_TF_SF(Sig,N_sensors,win_length, delta,L,step,FFT_len);
        end
    end
end


end

