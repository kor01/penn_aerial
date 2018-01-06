function [start_coeff, end_coeff] = snap_equation()

persistent start_c end_c;

if ~isempty(start_c)
    start_coeff = start_c;
    end_coeff = end_c;
    return;
end

start_coeff = zeros(8, 1);
% zeroth and first coefficient
start_coeff(1:2) = 1;

current = 1;
for i = 3:1:8
    current = current * (i - 1);
    start_coeff(i) = current;
end

end_coeff = zeros(8, 8);

for i = 1:1:8
    end_coeff(i, i:end) = 1;
    for j = i:1:8
        end_coeff(i, j) = factorial_ratio(j - 1, i - 1);
    end
end

start_coeff = diag(start_coeff);

start_c = start_coeff;
end_c = end_coeff;

end

function [ret] = factorial_ratio(k, n)

ret = 1;
for i = (k - n + 1) : 1 : k
    ret = ret * i;
end

end
