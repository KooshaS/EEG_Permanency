function y = aps(signal, min_freq, max_freq)
    
    sampling_rate = 512;
    absolute_power = abs(fft(signal));
    absolute_power = absolute_power(2:sampling_rate/2+1);
    y = absolute_power(min_freq:max_freq);
    
end







