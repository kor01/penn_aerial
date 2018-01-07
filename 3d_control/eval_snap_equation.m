function [pos, vel, acc, yaw, yaw_dot] = eval_snap_equation(...
    rel_t, coeffs, scale)

x = rel_t / scale;

vel = zeros(3, 1);
acc = zeros(3, 1);
pos = zeros(3, 1);

for c = 1:3
    
    coeff = squeeze(coeffs(:, c));
    x_orders = x .^ [0, 1, 2, 3, 4, 5, 6, 7]';
    
    % 7 order poly
    zeroth_order = x_orders .* coeff;
    
    % 6 order poly
    coeff = coeff(2:end) .* (1:7)';
    first_order = x_orders(1:7) .* coeff;
    
    % 5 order poly
    coeff = coeff(2:end) .* (1:6)';
    second_order = x_orders(1:6) .* coeff; 
    
    pos(c) = sum(zeroth_order);
    vel(c) = sum(first_order);
    acc(c) = sum(second_order);
end

% back to dt

vel = vel / scale;
acc = acc / scale;

yaw = atan2(vel(2), vel(1));
yaw_dot = atan2(acc(2), acc(1));

end
