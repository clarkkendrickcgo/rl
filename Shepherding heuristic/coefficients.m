function coefficients
    global rho_a;  %agent to agent interaction 
    global c;   %relative strength of attraction to center of mass
    global rho_s;  %agenta to shepherd interaction
    global h;    %strength to previous direction
    global e;    %noise
    global r_s;   %shepherd detection distance
    global r_a;    %agent detection distance
    global delta;  %agent displacement per time step

    rho_a = 2;
    c = 1.05;
    rho_s = 1;
    h = 0.5;
    e = 0.3;
    r_s = 65;
    r_a = 2;
    delta = 1;
end