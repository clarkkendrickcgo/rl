%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                        %%
%%%                  Written by Matthew Kontz                              %%
%%%                  Walla Walla College                                   %%
%%%                  Edward F. Cross School of Engineering                 %%
%%%                  February 2001                                         %%
%%%                  Simulation of a planar three link robot.              %%																								%%%
%%%                                                                        %%
%%%      The purpose of this function is to update the figure window       %%	
%%%      with the values, matrix and strings created by forkin.            %%
%%%                                                                        %%
%%%      This function is called by demobot.  To use, first execute        %%
%%%      demobot.  There are five files need to run demobot: demobot.m,    %%
%%%      option.m, forkin, invkin and setplot.                             %%
%%%                                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = setplot()
global xs ys xt yt 						% position variable
global xg yg Gt % handle for goal circle
global S1 S2 S3 S4 S5 S6						% position strings 
global pF1 pF2 pF3								% handles for fill
global Cs Ct									% handles for the joint's circle
global Js Jt									% handles for the joint's pluses
global dis											% handles for text display
global L1 L2 L3 Link1 Link2 Link3			% Link matrices
global STOP Chose T1 T2 T3
global f1 f2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(f1);
%set(pF1,'xdata',L1(1,:),'ydata',L1(2,:));	% 3 fills (2-t)
%set(pF2,'xdata',L2(1,:),'ydata',L2(2,:));    
%set(pF3,'xdata',L3(1,:),'ydata',L3(2,:));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for nsheep = 1:20
    set(Cs(nsheep),'xdata',xs(nsheep),'ydata',ys(nsheep)); % 3 circles
    %set(Js(nsheep),'xdata',xs(nsheep),'ydata',ys(nsheep)); % 3 plus
end

%set(Ct,'xdata',xt,'ydata',yt);  
set(Jt,'xdata',xt,'ydata',yt);
set(Gt,'xdata',xg,'ydata',yg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set(dis(3),'string',mat2str(S1)); 				% theta 1
%set(dis(4),'string',mat2str(S2));				% xt
%set(dis(5),'string',mat2str(S3));				% theta 2
%set(dis(6),'string',mat2str(S4));				% yt
%set(dis(7),'string',mat2str(S5));				% theta 3
%set(dis(8),'string',mat2str(S6)); 				% phi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axis([0 300 0 300])
end
