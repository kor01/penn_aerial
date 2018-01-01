function [ u1, u2 ] = controller(~, state, des_state, params)
%CONTROLLER  Controller for the planar quadrotor
%
%   state: The current state of the robot with the following fields:
%   state.pos = [y; z], state.vel = [y_dot; z_dot], state.rot = [phi],
%   state.omega = [phi_dot]
%
%   des_state: The desired states are:
%   des_state.pos = [y; z], des_state.vel = [y_dot; z_dot], des_state.acc =
%   [y_ddot; z_ddot]
%
%   params: robot parameters

%   Using these current and desired states, you have to compute the desired
%   controls


kp = 25; kv = 10;

rc = kp * (des_state.pos - state.pos) + ... 
    kv * (des_state.vel - state.vel) + des_state.acc;

phi_c = -rc(1) / params.gravity;


%if abs(phi_c) > pi / 36
%    phi_c = pi / 36 * sign(phi_c);
%end

weight = params.mass * params.gravity;

u1 = weight + params.mass * rc(2);

k_phi_p = 1000; k_phi_v = 150;

u2 = params.Ixx * (k_phi_p * (phi_c - state.rot) - k_phi_v * state.omega);

end

