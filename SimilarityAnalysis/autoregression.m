function y = autoregression(signal, order)
    
    mb = ar(signal, order, 'burg');
    ar_coef = mb.a;
    y = ar_coef(2:order + 1);    
    
end







