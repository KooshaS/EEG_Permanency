function graphTrend(data)

    %%% Indicates the positive or negative trend of a graph %%%
    detrend_data = detrend(data);
    trend = data - detrend_data;
    plot(trend)
    
end




