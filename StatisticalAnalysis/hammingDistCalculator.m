function y = hammingDistCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Hamming distance between daily samples %%%%%%
    hamming_dist = zeros(filesNumber, 1);
    for i = 1:filesNumber
        hamming_dist(i,:) = pdist([data(1, :);data(i, :)],'hamming');
    end
    
    y = hamming_dist;

end