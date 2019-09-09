function y = interpolationPlot(data)

    filesNumber = size(data,1);
    day = linspace(1, filesNumber, filesNumber);
    
    %%% Estimating missing data %%%
    [F,TF] = fillmissing(data, 'nearest', 'SamplePoints', day);
    plot(day, data, 'k*', day(TF), F(TF), 'ro')
    hold on
    plot(F, 'b')
    
    y = F;
    
end




