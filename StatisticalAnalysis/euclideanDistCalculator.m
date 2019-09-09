function y = euclideanDistCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Euclidean distance between daily samples %%%%%%
    euclidean_dist = zeros(filesNumber, 1);
    for i = 1:filesNumber
        euclidean_dist(i,:) = pdist([data(1, :);data(i, :)],'euclidean');
    end
    
    y = euclidean_dist;

end