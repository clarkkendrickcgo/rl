function new_pos = sheep_move(H,A)
    global delta;
    mag_H = sqrt(H(:,1).^2 + H(:,2).^2);
    H = bsxfun(@rdivide, H, mag_H); % normalize
    new_pos = A + (delta*H);
end