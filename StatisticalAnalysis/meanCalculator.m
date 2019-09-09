function y = meanCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Mean of raw signal %%%%%%
    raw_mean = zeros(filesNumber, 1);
    for i = 1:filesNumber
        raw_mean(i,:) = mean(data(i,:));
    end
    
    y = raw_mean;

end