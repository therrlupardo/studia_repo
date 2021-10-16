function crossed = yx(x, alpha, v, y_start_interval, y_end_interval)
%YX Summary of this function goes here
%   Detailed explanation goes here
    y = y_val(x, alpha, v);
    crossed = y > y_start_interval && y < y_end_interval;
end

