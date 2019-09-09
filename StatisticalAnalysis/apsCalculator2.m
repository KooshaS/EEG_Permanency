function y = apsCalculator2(data, min_freq, max_freq)

    filesNumber = size(data,1);
    sampling_rate = 512;
    epochsNumber = size(data,2)/sampling_rate;
    
    %%%%%% Power spectral density %%%%%%
    freq_band_psd = zeros(filesNumber*epochsNumber, max_freq - min_freq + 1);
    for i = 1:filesNumber
        epochs_psd = zeros(120, max_freq - min_freq + 1);
        for j = 1:epochsNumber
            epoch = data(i,(j-1)*sampling_rate + 1:j*sampling_rate);
            psd = abs(fft(epoch));
            psd = psd(2:sampling_rate/2+1);
            epochs_psd(j, :) = psd(min_freq:max_freq); 
        end
        freq_band_psd((i-1)*epochsNumber+1:i*epochsNumber,:) = epochs_psd;
    end
    
    y = freq_band_psd;

end