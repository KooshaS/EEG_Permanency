function y = statisticAnalysis(signal)
    
    y = [mean(signal) skewness(signal) kurtosis(signal) std(signal) min(signal) max(signal) max(signal)-min(signal)]; 
        
end







