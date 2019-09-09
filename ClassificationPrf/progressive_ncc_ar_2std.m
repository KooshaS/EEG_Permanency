function y = progressive_ncc_ar_2std(data, order)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    weeksNumber = floor(filesNumber/7);
    feature_dim = order;
    
    %%%%%% Power spectral density %%%%%%    
    avg_prog_ncc_prf = zeros(weeksNumber, 1);
    for week = 1:weeksNumber
        
        %%% Training NCC (normal distribution estimation) Weekly %%%
        epochs_psd = zeros((epochsNumber/2) * week * 7, feature_dim);
        
        for i = 1:week * 7
            for j = 1:epochsNumber/2
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd((i - 1)*epochsNumber/2 + j, :) = NaN(1, feature_dim);
                else
                    mb = ar(epoch, order, 'burg');
                    ar_coef = mb.a;
                    epochs_psd((i - 1)*epochsNumber/2 + j, :) = ar_coef(2:feature_dim + 1);
                end                            
            end        
        end
                                                                         
        epochs_psd = epochs_psd(all(~isnan(epochs_psd),2),:);
        [muhat,sigmahat] = normfit(epochs_psd);
        
        prog_ncc_prf = zeros(filesNumber - week * 7, 1);
        epochs_psd = zeros(epochsNumber, feature_dim);
        for i = 1:filesNumber - week * 7            
            for j = 1:epochsNumber
                epoch = data(i + week * 7,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd(i, :) = NaN(1, feature_dim);
                else
                    mb = ar(epoch, order, 'burg');
                    ar_coef = mb.a;
                    epochs_psd(j, :) = ar_coef(2:feature_dim + 1); 
                end
            end

            %%% Testing NCC %%%
            FR = 0;
            TA = 0;
            for j = 1:epochsNumber/2
                sum = -1;
                for k = 1:size(epochs_psd, 2)
                   sum = sum + (epochs_psd(epochsNumber/2 + j, k) - muhat(1, k))^2/(2*sigmahat(1, k))^2;
                end

                if sum < 0
                    TA = TA + 1;
                elseif sum >= 0
                    FR = FR + 1;
                else
                    TA = NaN;
                end                

            end

            prog_ncc_prf(i, :) = 100 * TA/(TA + FR);

        end
        
        avg_prog_ncc_prf(week, :) = nanmean(prog_ncc_prf); 
        
    end
    
    y = avg_prog_ncc_prf;

end











