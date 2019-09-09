function y = dwtExtractor(data, level)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    feature_dim = 7;
    
    %%%%%% AR Coefficients %%%%%%
    dwt_decomp = zeros(filesNumber, feature_dim);
    for i = 1:filesNumber
        epochs_dwt = zeros(epochsNumber, feature_dim);
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
        dwt_decomp(i,:) = mean(epochs_dwt, 1);
    end
    
    y = dwt_decomp;

end