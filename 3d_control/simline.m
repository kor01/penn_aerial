close all;
clear;

addpath('utils');

%% pre-calculated trajectories
trajhandle = @traj_line;

%% controller
controlhandle = @controller;

% Run simulation with given trajectory generator and controller
% state - n x 13, with each row having format [x, y, z, xdot, ydot, zdot, qw, qx, qy, qz, p, q, r]
[t, state] = simulation_3d(trajhandle, controlhandle);
