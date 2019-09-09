function y = fixedTst_ncc_sa_2std(data)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    feature_dim = 7;
    weeks_trn = 12;
     
    %%%%%% Power spectral density %%%%%%    
    avg_prog_ncc_prf = zeros(weeks_trn, 1);
    for week = 1:weeks_trn
        
        %%% Training NCC (normal distribution estimation) Weekly %%%
        epochs_psd = zeros((epochsNumber) * 7, feature_dim);
        
        for i = (week - 1) * 7 + 1:week * 7
            for j = 1:epochsNumber
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, :) = NaN(1, feature_dim);
                else
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 1) = mean(epoch);
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 2) = skewness(epoch);
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 3) = kurtosis(epoch);
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 4) = std(epoch);
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 5) = min(epoch);
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 6) = max(epoch);
                    epochs_psd((i - (week - 1) * 7)*epochsNumber + j, 7) = max(epoch) - min(epoch);                                                                                
                end                            
            end        
        end
        
        epochs_psd = epochs_psd(all(~isnan(epochs_psd),2),:);
        [muhat,sigmahat] = normfit(epochs_psd);
        
        prog_ncc_prf = zeros(filesNumber - weeks_trn * 7, 1);
        epochs_psd = zeros(epochsNumber, feature_dim);
        for i = weeks_trn * 7 + 1:filesNumber            
            for j = 1:epochsNumber
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                
                epochs_psd(j, 1) = mean(epoch);
                epochs_psd(j, 2) = skewness(epoch);
                epochs_psd(j, 3) = kurtosis(epoch);
                epochs_psd(j, 4) = std(epoch);
                epochs_psd(j, 5) = min(epoch);
                epochs_psd(j, 6) = max(epoch);
                epochs_psd(j, 7) = max(epoch) - min(epoch);                
            end

            %%% Testing NCC %%%
            FR = 0;
            TA = 0;
            for j = 1:epochsNumber
                sum = -1;
                for k = 1:size(epochs_psd, 2)
                   sum = sum + (epochs_psd(j, k) - muhat(1, k))^2/(2*sigmahat(1, k))^2;
                end

                if sum < 0
                    TA = TA + 1;
                elseif sum >= 0
                    FR = FR + 1;
                else
                    TA = NaN;
                end                

            end

            prog_ncc_prf(i - weeks_trn * 7, :) = 100 * TA/(TA + FR);

        end
        
        avg_prog_ncc_prf(week, :) = nanmean(prog_ncc_prf); 
        
    end
    
    y = avg_prog_ncc_prf;

end







