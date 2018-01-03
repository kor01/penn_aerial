function [F, M] = controller(t, state, des_state, params)
%CONTROLLER  Controller for the quadrotor
%
%   state: The current state of the robot with the following fields:
%   state.pos = [x; y; z], state.vel = [x_dot; y_dot; z_dot],
%   state.rot = [phi; theta; psi], state.omega = [p; q; r]
%
%   des_state: The desired states are:
%   des_state.pos = [x; y; z], des_state.vel = [x_dot; y_dot; z_dot],
%   des_state.acc = [x_ddot; y_ddot; z_ddot], des_state.yaw,
%   des_state.yawdot
%
%   params: robot parameters

%   Using these current and desired states, you have to compute the desired
%   controls


% =================== Your code goes here ===================

% Thrust

m = params.mass; g = params.gravity;

kp = 25; kv = 10;


%% target acceleration
rc = des_state.acc + kv * (des_state.vel - state.vel) ...
    + kp * (des_state.pos - state.pos);

%% target rotation
psi = state.rot(3);
spsi = sin(psi); cpsi = cos(psi);
rot_c = [spsi cpsi; -cpsi spsi]' * rc(1:2);

rot_c = [rot_c; des_state.yaw];

F = m * (g + rc(3));

% Moment, large k values makes attitude controller more sensitive
k_av = 200; k_ap = 1000;
M = params.I * (-k_av * state.omega + k_ap * (rot_c - state.rot));
%M = [0.1, 0.1, 0.1]';
%M = zeros(3, 1);

% =================== Your code ends here ===================

end
