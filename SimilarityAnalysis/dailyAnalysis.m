function [y, change] = dailyAnalysis(data)

    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    feature_dim = 7;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    total_days = size(data,1);
     
    %%%%%% Power spectral density %%%%%%    
    avg_sim = zeros(total_days, 1);
    
                                 
        %%% Training NCC (normal distribution estimation) Weekly %%%
        epochs_psd = zeros(epochsNumber, feature_dim);
                
        for i = 1:epochsNumber
            epoch = data(1,(i-1)*sampling_rate + 1:i*sampling_rate);
            if isnan(epoch(1,1))
                epochs_psd(i, :) = NaN(1, feature_dim);
            else                
                epochs_psd(i, :) = discrete_WT(epoch, 10);%%%%%%%%%%%%%%%%%%%%%%%
            end                            
        end                                                             
                       
        similarity = zeros(epochsNumber * epochsNumber, 1);
        epochs_psd2 = zeros(epochsNumber, feature_dim);
        for i = 1:total_days           
            for j = 1:epochsNumber
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd2(j, :) = NaN(1, feature_dim);
                else                    
                    epochs_psd2(j, :) = discrete_WT(epoch, 10);%%%%%%%%%%%%%%%%%%
                end 
            end
            
            for m = 1:epochsNumber
               for n = 1:epochsNumber
%                    similarity((m - 1)*epochsNumber + n,:) = 1 - pdist([epochs_psd(m, :);epochs_psd2(n, :)],'cosine');
%                    similarity((m - 1)*epochsNumber + n,:) = 1 - pdist([epochs_psd(m, :);epochs_psd2(n, :)],'correlation');
%                    similarity((m - 1)*epochsNumber + n,:) = pdist([epochs_psd(m, :);epochs_psd2(n, :)],'euclidean');
                    similarity((m - 1)*epochsNumber + n,:) = mandist(epochs_psd(m, :), epochs_psd2(n, :)');
               end                               
            end
            
            avg_sim(i, :) = nanmean(similarity); 
            
        end
          
    y = avg_sim;
    
    detrend_data = detrend(interpolationPlot(y));
    trend = interpolationPlot(y) - detrend_data;
    change = (trend(end) - trend(1))*100/trend(1);

end







