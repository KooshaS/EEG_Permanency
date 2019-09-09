function y = weekly_ncc_dwt_2std(data, level)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    weeksNumber = floor(filesNumber/7);
    feature_dim = 7;
    
    %%%%%% Power spectral density %%%%%%
    weekly_ncc_prf = zeros(filesNumber, 1);
    for week = 1:weeksNumber
        
        %%% Training NCC (normal distribution estimation) Weekly %%%
        epochs_psd = zeros(epochsNumber, feature_dim);
        muhat = NaN;
        day = (week - 1)*7 + 1;
        while (isnan(muhat(1,1))) % Check for the previous available training data
            for i = 1:epochsNumber
                epoch = data(day,(i-1)*sampling_rate + 1:i*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd(i, :) = NaN(1, feature_dim);
                else
                    for j = 1:level
                        [cA,cD] = dwt(epoch,'sym4');
                        epoch = cA;
                    end   
                    epochs_psd(i, :) = cA; 
                end
            end

            [muhat,sigmahat] = normfit(epochs_psd(1:epochsNumber/2, :));
            day = day - 1;
        
        end
        
        for i = (week - 1)*7 + 1:week*7

            for j = 1:epochsNumber
                epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
                if isnan(epoch(1,1))
                    epochs_psd(j, :) = NaN(1, feature_dim);
                else
                    for k = 1:level
                        [cA,cD] = dwt(epoch,'sym4');
                        epoch = cA;
                    end   
                    epochs_psd(j, :) = cA;  
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

            weekly_ncc_prf(i, :) = 100 * TA/(TA + FR);

        end
    end
    
    y = weekly_ncc_prf;

end