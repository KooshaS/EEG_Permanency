function y = psDensity(signal, min_freq, max_freq)
    
    sampling_rate = 512;
    pxx = periodogram(signal);
    pxx = pxx(2:sampling_rate/2+1);
    y = pxx(min_freq:max_freq);    
    
end







