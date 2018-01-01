function [ u ] = pd_controller(~, s, s_des, params)
%PD_CONTROLLER  PD controller for the height
%
%   s: 2x1 vector containing the current state [z; v_z]
%   s_des: 2x1 vector containing desired state [z; v_z]
%   params: robot parameters

Kp = 100;
Kv = 15;

error = s_des - s;

u = params.mass * (s_des(2) + Kp * error(1) + ... 
    Kv * error(2) + params.gravity);

end

