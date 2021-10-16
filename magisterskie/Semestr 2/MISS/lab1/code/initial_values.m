%INITIAL_VALUES Summary of this function goes here
%   Detailed explanation goes here
function values = initial_values(n, alpha_interval_end, v_interval_end)
   alpha = rand(n, 1) * (alpha_interval_end-1) + 1;
   v = rand(n, 1) * (v_interval_end-1) + 1;
   values = [alpha, v];
end
