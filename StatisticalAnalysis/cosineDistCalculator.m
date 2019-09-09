function y = cosineDistCalculator(data)

    filesNumber = size(data,1);
    
    %%%%%% Cosine similarity between daily samples %%%%%%
    cosine_similarity = zeros(filesNumber, 1);
    for i = 1:filesNumber
        cosine_similarity(i,:) = 1 - pdist([data(1, :);data(i, :)],'cosine');
    end
    
    y = cosine_similarity;

end