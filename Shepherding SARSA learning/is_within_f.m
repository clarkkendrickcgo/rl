function truth = is_within_f(A)
    global r_a;

    %% get center of mass
    COM = center_of_mass(A);
    
    %% solve for critical distance
    n = size(A,1);
    f = r_a*(n^(2/3));
    
    %% solve for distances
    dist_to_sheep = sqrt(sum((A - repmat(COM,n,1)).^2,2));

    if dist_to_sheep < f
        truth = 1;
    else
        truth = 0;
    end
end