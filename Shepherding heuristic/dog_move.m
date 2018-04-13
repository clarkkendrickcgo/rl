function new_pos = dog_move(S,P,A)
    %% distances from dog to sheep
    dist_dog_sheep = find_dist_dog_to_sheep(S,A);

    global r_a;

    %% solve for size of step
    if all(dist_dog_sheep > 3*r_a) == 0
        mag = 0.3 * r_a;
    else
        mag = 1.5;
    end
    
    %% solve for increment in x and y components
    direction = P-S;
    factor = mag./norm(direction);
    increment = direction * factor;

    new_pos = S + increment;
end
%{
plot([current_pos(1) new_pos(1)],[current_pos(2) new_pos(2)],'r','LineWidth', 3);
hold on
drawnow()
%}