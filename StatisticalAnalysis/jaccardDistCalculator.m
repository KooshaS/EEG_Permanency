function y = jaccardDistCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Jaccard distance between daily samples %%%%%%
    jaccard_dist = zeros(filesNumber, 1);
    for i = 1:filesNumber
        jaccard_dist(i,:) = pdist([data(1, :);data(i, :)],'jaccard');
    end
    
    y = jaccard_dist;

end