function y = ncc_aps_2std(data, min_freq, max_freq)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    
    %%% Training NCC (normal distribution estimation) %%%
    epochs_psd = zeros(epochsNumber, max_freq - min_freq + 1);
    for i = 1:epochsNumber
        epoch = data(1,(i-1)*sampling_rate + 1:i*sampling_rate);
        psd = abs(fft(epoch));
        psd = psd(2:sampling_rate/2+1);
        epochs_psd(i, :) = psd(min_freq:max_freq); 
    end
    
    [muhat,sigmahat] = normfit(epochs_psd(1:epochsNumber/2, :));

    %%%%%% Power spectral density %%%%%%
    ncc_prf = zeros(filesNumber, 1);
    for i = 1:filesNumber
        for j = 1:epochsNumber
            epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
            psd = abs(fft(epoch));
            psd = psd(2:sampling_rate/2+1);
            epochs_psd(j, :) = psd(min_freq:max_freq); 
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
        
        ncc_prf(i, :) = 100 * TA/(TA + FR);
        
    end
    
    y = ncc_prf;

end