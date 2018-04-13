function  ArmDemo( maxepisodes )
%ArmDemo, the main function of the demo
%maxepisodes: maximum number of episodes to run the demo
global TxtEpisode goal f1 f2 grafica MOVIE T1 T2 T3 xg yg

%MOVIE = getframe(gcf);

clc
statelist   = BuildStateList();  % the list of states
actionlist  = BuildActionList(); % the list of actions

nstates     = size(statelist,1);
nactions    = size(actionlist,1);

Q1           = BuildQTable( nstates,nactions );  % the QTable
Q2           = BuildQTable( nstates,nactions );  % the QTable

%load('Qtables_goal.mat');
%load('Qtables_adaptive.mat');
%load('Qtables_verygood.mat');

maxsteps    = 1200;  % maximum number of steps per episode
alpha       = 0.3;  % learning rate
gamma       = 1;  % discount factor
epsilon     = 0.10; % probability of a random action selection
grafica     = false; % indicates if display the graphical interface

xpoints=[];
ypoints=[];


for i=1:maxepisodes 
    [xf yf]= randgoal();  % activate the random location of the goal
    xg = xf;
    yg = yf;
    set(goal,'xdata',xf,'ydata',yf);

    set(TxtEpisode,'string',strcat('Episode: ',int2str(i)));     
    [total_reward,steps,Q1,Q2] = ArmEpisode( maxsteps, Q1, Q2, xf , yf, alpha, gamma,epsilon,statelist,actionlist,grafica );    
    
    if (mod(i,20)==0)
        save Qtables.mat Q1 Q2;
    end
    
    disp(['Episode: ',int2str(i),' steps: ',int2str(steps),' reward: ',num2str(total_reward),' epsilon:',num2str(epsilon)])
    
    xpoints(i) = i-1;

    ypoints(i) = steps;

    subplot(f2);
    plot(xpoints,ypoints);
    xlabel('Episodes');
    ylabel('num of step');

    subplot(f1);

    setplot;
    drawnow;
    epsilon = epsilon * 0.99;
    

    
    if (i>1000000)
        grafica=true;
    end

    
end






