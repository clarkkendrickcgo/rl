


% 
% %%avi making
% filename='filename';
% writerObj = VideoWriter('shepherding.avi');
% writerObj.FrameRate=6;
% open(writerObj); 
% fig = figure('position',[500 500 800 350]);
%     axis tight;
%     set(gca,'nextplot','replacechildren');
%     set(gcf,'Renderer','zbuffer');
% 




%% set all coefficients
coefficients;
global r_a;

%% initialize sheep positions   
prompt = 'how many sheep? ';
n = input(prompt); % ask user for number
% n = 10;
away = 75;
A = gen_sheep(n,away); % sheep position

%% initialize target position
target = [20, 0];

%% initialize dog position
% temp = 75 * rand; % set y value of dog from 0 to 75
init_S = [0 50];
S = init_S;

%% initialize inertia
H = zeros(n,2) + 1;

%% run simulation
figure(1)
COM = center_of_mass(A);
message = 'wala pa';
counter = 0;

while norm(target - COM) > 1
    counter = counter + 1;
    COM = center_of_mass(A); 
    farthest_sheep = find_farthest_sheep(A);
    
    %features
    phi(counter,1) = distance(COM(:,1), COM(:,2),farthest_sheep(:,1), farthest_sheep(:,2)); %distance from center of mass to farthest sheep
    phi(counter,2) = distance(S(:,1), S(:,2), COM(:,1), COM(:,2)); %distance from center of mass to dog
    phi(counter,3) = distance(COM(:,1), COM(:,2), target(:,1), target(:,2)); %distance from center of mass to target
    phi(counter,4) = distance(S(:,1), S(:,2), target(:,1), target(:,2));%distance from dog to target
    phi(counter,5) = S(:,1);
    phi(counter,6) = S(:,2);
    phi(counter,7) = COM(:,1);
    phi(counter,8) = COM(:,2);
    
    
    
    %% determine dog goal position
    if is_within_f(A) % within critical distance 
        % herd
        message = 'herding';
        direction = (COM-target) / norm(COM-target);
        factor = r_a*(sqrt(n));
        P = COM + (direction*factor);
    else
        % collect
        message = 'collecting';
        farthest_sheep = find_farthest_sheep(A); % look for location of farthest sheep
        direction = (farthest_sheep-COM) / norm(farthest_sheep-COM);
        factor = r_a;
        P = farthest_sheep + (direction*factor);
    end


    %% find new dog position
    new_dog_pos = dog_move(S,P,A); %dog,goal,sheep

    %% find new inertia
    new_inertia = find_new_inertia(H,A,S); %inertia,sheep,dog

    %% find new sheep position
    %new_sheep_pos = sheep_move(H,A); %inertia,sheep
    new_sheep_pos = sheep_move(new_inertia,A); %inertia,sheep

    %% update positions
    S = new_dog_pos;
    H = new_inertia;
    A = new_sheep_pos;
    
    if mod(counter,5) == 0
        clf;
        %% plot
        line_size = 2;
        % sheep
        scatter(A(:,1),A(:,2),'bo','linewidth',line_size);
        hold on;
        % dog
        scatter(S(1),S(2),'ro','linewidth',line_size);
        hold on;
        % goal
        scatter(target(1),target(2),'kx','linewidth',line_size);
        hold on;
        % starting point
        scatter(init_S(1),init_S(2),'gx','linewidth',line_size);
        hold on;

        title(message);
        xlim([0 300]);
        ylim([0 300]);
        
        
%         %%avi making continuation
%         frame = getframe(fig);
%         writeVideo(writerObj,frame);
    end
    pause(0.0001);
    
    
    
end
title('goal!');


% counter

% close(writerObj);
% 
% filename = sprintf('fixedinitialposition_%02d.mat', k); 
% % message = sprintf('About to save phi into new file %s.', filename);
% % uiwait(helpdlg(message));
% save(filename,'phi');
% clear
% 
% 
% end
% 

