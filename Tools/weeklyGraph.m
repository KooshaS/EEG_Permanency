function y = weeklyGraph(data)

    filesNumber = size(data,1);
    weeksNumber = floor(filesNumber/7);
    
    %%%%%% Weekly segmentation of data %%%%%%
    if mod(filesNumber, 7) == 0
        weeklyData = zeros(weeksNumber, 1);
        for i = 1:weeksNumber
        weeklyData(i, 1) = mean(data((i - 1)*7 + 1: i*7, 1));     
        end
    else
        weeklyData = zeros(weeksNumber + 1, 1);
        for i = 1:weeksNumber
        weeklyData(i, 1) = mean(data((i - 1)*7 + 1: i*7, 1));     
        end
        weeklyData(i + 1, 1) = mean(data(i*7 + 1: end, 1));
    end
    
    y = weeklyData;

end