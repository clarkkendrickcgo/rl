function [ xp ] = ArmDoAction( force )
%MountainCarDoAction: executes the action (a) into the mountain car
%environment
% a: is the force to be applied to the car
% x: is the vector containning the position and speed of the car
% xp: is the vector containing the new position and velocity of the car

global xt yt grafica

% starting point
linex = xt;
liney = yt;

xt = xt + force(1);
yt = yt + force(2);

% ending point
linex = [linex;xt];
liney = [liney;yt];

%forkin;

xp=[];
xp(1) = xt;
xp(2) = yt;

%%%%% add line %%%%%
% NOTE TO CLARK: if you want to see the path even if the "Step Graph"
% button is not pressed, then comment/delete out the condition
if (grafica==true)
    line(linex,liney,'LineWidth',1,'Color',[0 0 1]);
end