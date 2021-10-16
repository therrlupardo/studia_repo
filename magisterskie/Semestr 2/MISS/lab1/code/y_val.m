function y = y_val(x, alpha, v)
%YX Summary of this function goes here
%   Detailed explanation goes here
    radians = deg2rad(alpha);
    g = 10;
    a = (-1) * g / (2 * (v * cos(radians)) * (v * cos(radians)));
    b = sin(radians) / cos(radians);
    
    y = x * x * a + x * b;
end

