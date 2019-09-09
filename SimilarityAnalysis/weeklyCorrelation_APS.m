% function y = weeklyCorrelation_APS(data, min_freq, max_freq)

data = rawData;
min_freq = 1;
max_freq = 4;

    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    feature_dim = max_freq - min_freq + 1;
    weeks_tst = 13;
     
    %%%%%% Power spectral density %%%%%%    
    avg_corr = zeros(weeks_tst, 1);
    for week = 1:weeks_tst
        
        %%% Training NCC (normal distribution estimation) Weekly %%%
        epochs_psd = zeros((epochsNumber) * 7, feature_dim);
        
        for i = 1:7 - 1
            for j = 1:epochsNumber
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd(i*epochsNumber + j, :) = NaN(1, feature_dim);
                else
                    psd = abs(fft(epoch));
                    psd = psd(2:sampling_rate/2+1);
                    epochs_psd(i*epochsNumber + j, :) = psd(min_freq:max_freq);
                end                            
            end        
        end
        
%         epochs_psd = epochs_psd(all(~isnan(epochs_psd),2),:);
                       
        cosine_similarity = zeros((epochsNumber) * 7, 1);
        epochs_psd2 = zeros((epochsNumber) * 7, feature_dim);
        for i = (week)*7 + 1:(week + 1)*7 - 1           
            for j = 1:epochsNumber
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd2((i - (week)*7)*epochsNumber + j, :) = NaN(1, feature_dim);
                else
                    psd = abs(fft(epoch));
                    psd = psd(2:sampling_rate/2+1);
                    epochs_psd2((i - (week)*7)*epochsNumber + j, :) = psd(min_freq:max_freq);
                end 
            end

            for j = 1:(epochsNumber) * 7                
%                 cosine_similarity(j,:) = 1 - pdist([epochs_psd(j, :);epochs_psd2(j, :)],'jaccard');
                cosine_similarity(j,:) = pdist([epochs_psd(j, :);epochs_psd2(j, :)],'chebychev');
            end                       
        end
        
        avg_corr(week, :) = nanmean(cosine_similarity); 
        
    end
    
    y = avg_corr;
    clc

% end







