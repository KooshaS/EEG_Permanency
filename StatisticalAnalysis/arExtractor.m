function y = arExtractor(data, order)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    feature_dim = order;
    
    %%%%%% AR Coefficients %%%%%%
    ar_coef = zeros(filesNumber, feature_dim);
    for i = 1:filesNumber
        epochs_ar = zeros(epochsNumber, feature_dim);
        for j = 1:epochsNumber
            epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
            
            if isnan(epoch(1,1))
                epochs_ar(j, :) = NaN(1, feature_dim);
            else
                mb = ar(epoch, order, 'burg');
                coef = mb.a;
                epochs_ar(j, :) = coef(2:feature_dim + 1); 
            end
            
        end
        ar_coef(i,:) = mean(epochs_ar, 1);
    end
    
    y = ar_coef;

end