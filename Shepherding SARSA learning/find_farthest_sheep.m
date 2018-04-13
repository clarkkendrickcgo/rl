function sheep = find_farthest_sheep(A)
    n = size(A,1);
    
    %% get center of mass
    COM = center_of_mass(A);
    
    %% solve for distances
    subtracted = A - repmat(COM,n,1);
    squared = subtracted.^2;
    summed = sum(squared,2);
    dist_to_sheep = sqrt(summed);
    
    %% solve for farthest sheep
    [temp, idx] = max(dist_to_sheep);
    sheep = A(idx,:);
end