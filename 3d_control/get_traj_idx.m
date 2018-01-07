function [traj_idx, rel_t] = get_traj_idx(t, num_traj, scale)

x = t / scale;

traj_idx = double(floor(x) + 1);

if traj_idx > num_traj
   rel_t = scale;
   traj_idx = num_traj;
else
    rel_t = double(t - scale * (traj_idx - 1));
end

end
