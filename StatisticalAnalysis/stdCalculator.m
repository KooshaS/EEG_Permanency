function y = stdCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Mean of raw signal %%%%%%
    raw_std = zeros(filesNumber, 1);
    for i = 1:filesNumber
        raw_std(i,:) = std(data(i,:));
    end
    
    y = raw_std;

end