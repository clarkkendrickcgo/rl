function new_dir = find_new_inertia(H,A,S)
    global h rho_a rho_s c r_s e;
    n = size(A,1);
    
    % inertia
    mag_H = sqrt(H(:,1).^2 + H(:,2).^2);
    H = bsxfun(@rdivide, H, mag_H); % normalize
    H(isnan(H)) = 0;
       
    %% ALL SHEEP
    % repulsion from other sheep whose distance is <r_a
    R_A = repulsion_others(A);
    mag_R_A = sqrt(R_A(:,1).^2 + R_A(:,2).^2);
    R_A = bsxfun(@rdivide, R_A, mag_R_A); % normalize
    R_A(isnan(R_A)) = 0;
    
    % SHEEP less than r_s from dog
    % find near
    dist_dog_sheep = find_dist_dog_to_sheep(S,A);
    near_sheep = find(dist_dog_sheep < r_s);
    % repulsion from dog
    R_S = zeros(n,2);
    num_near_sheep = length(near_sheep);
    R_S(near_sheep,:) = A(near_sheep,:) - repmat(S,num_near_sheep,1);
    mag_R_S = sqrt(R_S(:,1).^2 + R_S(:,2).^2);
    R_S = bsxfun(@rdivide, R_S, mag_R_S); % normalize
    R_S(isnan(R_S)) = 0;
    
    % attraction to COM
    C = zeros(n,2);
    COM = center_of_mass(A);
    C(near_sheep,:) = repmat(COM,num_near_sheep,1) - A(near_sheep,:);
    mag_C = sqrt(C(:,1).^2 + C(:,2).^2);
    C = bsxfun(@rdivide, C, mag_C); % normalize
    C(isnan(C)) = 0;
    
    % error term
    E = randn(n,2);
    mag_E = sqrt(E(:,1).^2 + E(:,2).^2);
    E = bsxfun(@rdivide, E, mag_E); % normalize
    
    %% update sheep position
    new_dir = (h*H) + (c*C) + (rho_a*R_A) + (rho_s*R_S) + (e*E);
    %new_dir = (h*H) + (c*C) + (rho_a*R_A) + (rho_s*R_S);
end