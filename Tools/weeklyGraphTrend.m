function weeklyGraphTrend(data)

    filesNumber = size(data,1);
    weeksNumber = floor(filesNumber/7);

    for i = 1:weeksNumber
        %%% Indicates the positive or negative trend of a graph %%%
        detrend_data = detrend(data((i - 1)*7 + 1:i*7, :));
        trend = data((i - 1)*7 + 1:i*7, :) - detrend_data;
        day = (i - 1)*7 + 1:i*7;
        plot(day, trend)
        
        %%% Adding gradient to plot %%%
        FX = gradient(trend);
        x1 = day(floor(size(day, 2)/2));
        y1 = trend(floor(size(trend, 1)/2));
        gradients = num2str(mean(FX));
%         text(x1, y1, gradients, 'fontweight','bold', 'Color', 'red', 'FontSize', 14)
        text(x1, y1, gradients, 'fontweight','bold')
        
        hold on
    end
    
end




