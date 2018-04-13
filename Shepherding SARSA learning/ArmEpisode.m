function [ total_reward,steps,Q1,Q2 ] = ArmEpisode( maxsteps, Q1, Q2, xf, yf , alpha, gamma,epsilon,statelist,actionlist,grafic )
%MountainCarEpisode do one episode of the mountain car
% maxstepts: the maximum number of steps per episode
% Q: the current QTable
% alpha: the current learning rate
% gamma: the current discount factor
% epsilon: probablity of a random action
% statelist: the list of states
% actionlist: the list of actions

global xt yt TxtSteps grafica MOVIE r_a xg yg
xg = xf;
yg = yf;

% initial state
xt = 0;
%yt = 0;
yt = 75 * rand; % set y value of dog from 0 to 75
S = [xt yt];
%forkin; % tool to calculate resultant angles for robotic arm

% initialize sheep positions 
coefficients;
n = 20;
away = 75;
A = gen_sheep(n,away); % sheep position
%COM = center_of_mass(A);
forksheep(A);

% initialize inertia
H = zeros(n,2) + 1;

steps = 0;
total_reward = 0;

% initial perception
% convert the continous state variables to an index of the statelist
s1   = DiscretizeState([(xf-xt) (yf-yt) ],statelist);
s2   = DiscretizeState([(xf-xt) (yf-yt) ],statelist);

% selects an action using the epsilon greedy selection strategy
a1 = e_greedy_selection(Q1,s1,epsilon);
a2 = e_greedy_selection(Q2,s2,epsilon);

target = [210 , 46]; % target

% clear dog path lines before new episode begins
set(0,'showhiddenhandles','on')
h = findobj('Color','b');
delete(h);

for i=1:maxsteps   

    
    
    % TEST: goal setting of dog
    COM = center_of_mass(A);
    if is_within_f(A) % within critical distance 
        % herd
        %message = 'herding';
        direction = (COM-target) / norm(COM-target);
        factor = r_a*(sqrt(n));
        P = COM + (direction*factor);
    else
        % collect
        %message = 'collecting';
        farthest_sheep = find_farthest_sheep(A); % look for location of farthest sheep
        direction = (farthest_sheep-COM) / norm(farthest_sheep-COM);
        factor = r_a;
        P = farthest_sheep + (direction*factor);
    end
    xf = P(1); yf = P(2);
    xg = xf; yg = yf;
    
    % sheep
    %farthest_sheep = find_farthest_sheep(A);
    forksheep(A);
    
    %% set dog position
    S = [xt yt];
    
    % find new inertia
    new_inertia = find_new_inertia(H,A,S); %inertia,sheep,dog
    
    % find new sheep position
    new_sheep_pos = sheep_move(new_inertia,A); %inertia,sheep
    
    % convert the index of the action into an action value
    action1 = actionlist(a1);    
    action2 = actionlist(a2);      
    
    %do the selected action and get the next car state      				
    xp  = ArmDoAction([action1 action2]);
       
    % observe the reward at state xp and the final state flag
    %[r,f]        = ArmGetReward(xp,xf,yf);
    [r,f]        = ArmGetReward(xp,xf,yf,A);
    total_reward = total_reward + r;
    
    % convert the continous state variables in [xp] to an index of the statelist    
    sp1   = DiscretizeState([(xf-xt) (yf-yt) ],statelist);
    sp2   = DiscretizeState([(xf-xt) (yf-yt) ],statelist);  
    
    % selects an action using the epsilon greedy selection strategy
    ap1 = e_greedy_selection(Q1,sp1,epsilon);
    ap2 = e_greedy_selection(Q2,sp2,epsilon);
    
    % Update the Qtable, that is,  learn from the experience    
    Q1 = UpdateSARSA( s1, a1, r, sp1, ap1, Q1 , alpha, gamma );
    Q2 = UpdateSARSA( s2, a2, r, sp2, ap2, Q2 , alpha, gamma );
    
    %update the current state
    s1 = sp1;
    s2 = sp2;
    
    %update the current action
    a1 = ap1;
    a2 = ap2;
    
    % update positions
    H = new_inertia;
    A = new_sheep_pos;
    
    grafic  = grafica; 
    pxt(i)=xt;
    pyt(i)=yt;
    if (grafic==true)
        set(TxtSteps,'string',strcat('Steps: ',int2str(steps+1)));
        setplot;
        
        pause(0.1); % remove
        %plot(xt,yt,'k')
        drawnow;
        %MOVIE(numel(MOVIE)+1) = getframe(gcf);
    end
    
    %increment the step counter.
    steps=steps+1;
    
    % if the car reachs the goal breaks the episode
    if (f==true)
        break
    end
end


