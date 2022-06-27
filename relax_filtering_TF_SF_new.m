function [ IF,Xout ] = relax_filtering_TF_SF_new( X,n_sources,N_sensors,win_length,delta,L,step,FFT_len )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Sig=X;
for i=1:n_sources
[IF(i,:),Xout(i,:),Veccc(i,:),Sig] = BSS_TF_SF(Sig,N_sensors,win_length, delta,L,step,FFT_len);

end
%figure; plot(IF.')
%IF1=IF;
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
            % Restimate i-th component
              [IF(i,:),Xout(i,:),Veccc(i,:),Sig] = BSS_TF_SF(Sig,N_sensors,win_length, delta,L,step,FFT_len);
              
        end
    end


end

