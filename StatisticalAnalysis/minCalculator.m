function y = minCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Min of raw signal %%%%%%
    raw_min = zeros(filesNumber, 1);
    for i = 1:filesNumber
        raw_min(i,:) = min(data(i,:));
    end
    
    y = raw_min;

end