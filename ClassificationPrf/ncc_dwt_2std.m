function y = ncc_dwt_2std(data, level)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    feature_dim = 7;
    
    %%% Training NCC (normal distribution estimation) %%%
    epochs_dwt = zeros(epochsNumber, feature_dim);
    for i = 1:epochsNumber
        epoch = data(1,(i-1)*sampling_rate + 1:i*sampling_rate);
        for j = 1:level
            [cA,cD] = dwt(epoch,'sym4');
            epoch = cA;
        end   
        epochs_dwt(i, :) = cA; 
    end
    
    [muhat,sigmahat] = normfit(epochs_dwt(1:epochsNumber/2, :));

    %%%%%% Power spectral density %%%%%%
    ncc_prf = zeros(filesNumber, 1);
    for i = 1:filesNumber
        for j = 1:epochsNumber
            epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
            if isnan(epoch(1,1))
                epochs_dwt(j, :) = NaN(1, feature_dim);
            else
                for k = 1:level
                    [cA,cD] = dwt(epoch,'sym4');
                    epoch = cA;
                end   
                epochs_dwt(j, :) = cA; 
            end
        end
        
        %%% Testing NCC %%%
        FR = 0;
        TA = 0;
        for j = 1:epochsNumber/2
            sum = -1;
            for k = 1:size(epochs_dwt, 2)
               sum = sum + (epochs_dwt(epochsNumber/2 + j, k) - muhat(1, k))^2/(2*sigmahat(1, k))^2;
            end
        
            if sum < 0
                TA = TA + 1;
            elseif sum >= 0
                FR = FR + 1;
            else
                TA = NaN;
            end                
            
        end
        
        ncc_prf(i, :) = 100 * TA/(TA + FR);
        
    end
    
    y = ncc_prf;

end