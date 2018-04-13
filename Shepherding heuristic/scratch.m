clc
clf
clear



n=3; %for simplicity this time. 
A_x = [10;40;80]; %initializing sheep x position
A_y = [86;50;81]; %initialziing sheep y position
A = [A_x,A_y]; %sheep position

rho_a = 2;
c = 1.05; 
rho_s = 1;
h = 0.5; 
e = 0.3; 


target_x = 20; %target x  
target_y = 0; %target y

global cm_x cm_y; 
global dist; 


scatter(A_x,A_y)
axis([0 250 0 250])
grid on
hold on

center_of_mass(A_x,A_y); %FUNCTION
scatter(cm_x,cm_y, 'blue' ,'filled');
dist = distance(cm_x, cm_y, A_x, A_y); %FUNCTION %center of mass distance to sheep

r_a = 2;
r_s = 65;
f = r_a*(n^(2/3)); 


if all(dist < f) == 0
    disp('collect');
    
    %identifying farthest point
    [max, idx] = max(dist);
    
      
    farthest_point_x = A(idx);
    farthest_point_y = A(idx+n); 
    farthest_point = [farthest_point_x, farthest_point_y]
    
    %identifying collection point P_c
    ell = distance(farthest_point_x,farthest_point_y,cm_x, cm_y); 
    
    P_x = farthest_point_x + (r_a/ell)*(farthest_point_x - cm_x);
    P_y = farthest_point_y + (r_a/ell)*(farthest_point_y - cm_y);
    P = [P_x, P_y]
    scatter(P_x,P_y, 'magenta' ,'x')

    
    
else
    disp('herd');
    
    %identifying driving point
    ell = distance(cm_x,cm_y, target_x,target_y);
    P_x = cm_x + (r_a*sqrt(n)/ell)*(cm_x - target_x);
    P_y = cm_y + (r_a*sqrt(n)/ell)*(cm_y - target_y);
    scatter(P_x,P_y, 'magenta', 'o')
    
end



%%%%%%%
init_pos = [0,0];
current_pos = init_pos;

for steps = 1:100
    %% sheep moving
    
    %% dog moving
    new_pos = dog_move(current_pos,P,A); %current,goal,sheep
    current_pos = new_pos;
end
%%%%%%%

