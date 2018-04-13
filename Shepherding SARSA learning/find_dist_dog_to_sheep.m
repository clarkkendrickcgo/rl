function distances = find_dist_dog_to_sheep(S,A)
    subtracted = A - repmat(S,size(A,1),1);
    squared = subtracted.^2;
    summed = sum(squared,2);
    distances = sqrt(summed);
end