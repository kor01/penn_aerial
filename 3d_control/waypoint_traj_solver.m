function [traj_coeff] = waypoint_traj_solver(waypoints)
% waypoints: The 3xP matrix listing all the points you much visited in order
% along the generated trajectory

num_traj = size(waypoints, 2) - 1;

idx = 1:1:num_traj;
diff_idx = 1:1:6;

[start_coeff, end_coeff] = snap_equation();

traj_coeff = zeros(8, num_traj, 3);

for c=1:1:3
    
    current_idx = 0;
    %% coefficient for start position
    weight = zeros(num_traj * 8, num_traj * 8);
    bias = zeros(num_traj * 8, 1);
    for i = 1:1:num_traj
        var_start = (i - 1) * 8;
        weight(i, var_start + 1) = 1;
        bias(i) = waypoints(c, i);
    end
    current_idx = current_idx + num_traj;
    
    %% coefficient for end position
    for i = 1:1:num_traj
        var_start = (i - 1) * 8;
        weight(current_idx + i, (var_start + 1): (var_start + 8)) = 1;
        bias(current_idx + i) = waypoints(c, i + 1);
    end
    current_idx = current_idx + num_traj;
     
    %% coefficient for start boundary condition
    for i=1:1:3
        weight(current_idx + 1, i + 1) = 1;
        current_idx = current_idx + 1;
    end
    
    %% coefficient for end boundary condition
    for i=1:1:3
        weight(current_idx + 1, end-7:end) = end_coeff(i + 1, :);
        current_idx = current_idx + 1;
    end
    
    %% 6 order continuous in intermidiary waypoints
    for i=1:1:(num_traj-1)
       var_idx = ((i - 1) * 8 + 1):1:(i*8);
       weight(current_idx + diff_idx, var_idx) = ...
           end_coeff(diff_idx+1, :);
       weight(current_idx + diff_idx, var_idx + 8) = ...
           -start_coeff(diff_idx+1, :);
       current_idx = current_idx + 6;
    end
    
    coeff = weight \ bias;
    coeff = reshape(coeff, [8 num_traj]);
    traj_coeff(:, :, c) = coeff;
end

end