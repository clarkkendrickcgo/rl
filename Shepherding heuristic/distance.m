function dis = distance(A,B,C,D)

%description: calculates the distance between points (x_1, y_1), (x_2, y_2). 
%syntax: distance(x_1,y_1,x_2,y_2)

global cm_x cm_y; 
global dis;



dummy_x = (C-A).^2;
dummy_y = (D-B).^2;
dis = sqrt(dummy_x + dummy_y)';

