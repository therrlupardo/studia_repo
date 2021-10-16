function crossed = xy(y, alpha, v, x_start_interval, x_end_interval)
%XY Summary of this function goes here
%   Detailed explanation goes here
    radians = deg2rad(alpha);
    g = 10;
    a = (-1) * g / (2 * (v * cos(radians)) * (v * cos(radians)));
    b = sin(radians) / cos(radians);
    c = -y;
    
    delta = b * b - 4 * a * c;
    if (delta < 0)
       crossed = false;
    elseif (delta == 0)
       x0 = -b / (2 * a);
       crossed = x0 > x_start_interval && x0 < x_end_interval;
    else 
       x1 = (-b + sqrt(delta)) / (2 * a);
       x2 = (-b - sqrt(delta)) / (2 * a);
       
      crossed = (x1 > x_start_interval && x1 < x_end_interval) || (x2 > x_start_interval && x2 < x_end_interval);
    end
end

