function R_A = repulsion_others(A)
    n = size(A,1);
    
    %% distance from one sheep to all the others in the flock.
    distance_matrix = zeros(n);
    for i = 1:n
        for j = 1:n
            distance_matrix(i,j) = norm(A(i,:)-A(j,:));
        end
    end

    %% picking those sheep who are within 2 meters from another.
    idx2 = find(distance_matrix < 2 & distance_matrix ~= 0);
    [row,column] = ind2sub(size(distance_matrix),idx2);
    [row,order] = sort(row, 'ascend');
    column = column(order);
    interact = [row,column];

    %% Force 3: repulsion from other sheep
    R_A = zeros(n,2);

    for val=1:n
        iv = interact(ismember(interact(:,1),val),2);
        transit = repmat(A(val,:),size(iv,1),1) - A(iv,:);
        norm_2 = sqrt((transit(:,1)).^2 +(transit(:,2)).^2);
        normalized = bsxfun(@rdivide, transit, norm_2);
        R_A(val,:) = sum(normalized,1); 
        
%         Z = sqrt(R_A(:,1).^2 + R_A(:,2).^2); 
%         normalized_2 = bsxfun(@rdivide, R_A, Z); 
%         R_A = normalized_2
        
    end
    
    
end