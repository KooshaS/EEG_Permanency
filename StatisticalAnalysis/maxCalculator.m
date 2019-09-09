function y = maxCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Max of raw signal %%%%%%
    raw_max = zeros(filesNumber, 1);
    for i = 1:filesNumber
        raw_max(i,:) = max(data(i,:));
    end
    
    y = raw_max;

end