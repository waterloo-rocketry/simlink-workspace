% I_xx = 0.22; % borealis dry I
% rho = 1.112; %kg/m^3 at 1000m
% L_ref = 0.15; %m, borealis OR reference length, nosecone diam
% A = pi*(L_ref/2)^2; %m2, borealis OR reference area, nosecone base cross section
% v = 250; %m/s, reference velocity

%setpoints
p_c = 0; %roll rate command
q_c = 0; %pitch rate cmmand
r_c = 0; %yaw rate command


%paper params
epsilon = 0.1
C = 2.0
K_act = 1.0
t_act = 10.0 %s
p_1hat = 0.01
p_2hat = 1.0
L_p = -0.1; %1/s^2 
