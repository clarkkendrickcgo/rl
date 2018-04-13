function [ r,f ] = ArmGetReward( x, xf, yf, A )
% GetReward returns the reward at the current state
% x: a vector of position of the last arm of the robot
% r: the returned reward.
% f: true if the car reached the goal, otherwise f is false
  
global xs ys xg yg
xf = xg;
yf = yg;

penalty = 1.0;
f       = false;
xt      = x(1);
yt      = x(2);

dist_1 = (xf-xt)^2 + (yf-yt)^2;
dist_2 = (xf-xs).^2 + (yf-ys).^2; 
% distance of COM from final goal
COM = center_of_mass(A);
%dist_3 = (COM(1)-210).^2 + (COM(2)-46).^2; 



r = -((dist_1^2)/100)  + (penalty);
r = r /10;

if ( sqrt(dist_1)<17 && penalty==1)
    r = 10^5;
end

if ( sqrt(dist_3)<7 && penalty==1)
%     r = 10^15;
    f =  true;

end

    
   


    
