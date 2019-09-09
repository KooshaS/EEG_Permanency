function y = discrete_WT(signal, level)
    
    for i = 1:level
        [cA,cD] = dwt(signal,'sym4');
        signal = cA;
    end   
    y = cA;    
    
end







