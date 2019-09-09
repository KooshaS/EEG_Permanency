function y = preprocessing(data)

    filesNumber = size(data,1);

    %%% Normalization %%%
%     data = data - mean(data, 2);
%     data = data./std(data, 0, 2);
    
    % Noise Cancelation using 40-Hz Low Pass Filter
    for i = 1:filesNumber
        Fs = 512;                                   % sample rate in Hz
        x = data(i,:);
        % Design a 70th order lowpass FIR filter with cutoff frequency of 40 Hz.
        Fnorm = 40/(Fs/2);                          % Normalized frequency
        df = designfilt('lowpassfir','FilterOrder',70,'CutoffFrequency',Fnorm);
        D = mean(grpdelay(df));                     % Filter delay in samples
        y = filter(df,[x'; zeros(D,1)]);            % Append D zeros to the input data
        y = y(D+1:end);                             % Shift data to compensate for delay              
        data(i,:) = y';
    end

    % Noise Cancelation using 7-order Haar Wavelet Transformation
    for i = 1:filesNumber
        x = data(i,:);      
        if isnan(x(1,1))
            data(i,:) = x;
        else
            y = wden(x,'modwtsqtwolog','s','mln',7,'haar');
            data(i,:) = y;
        end
    end

    y = data;

end





