function [value] = compute_frequency(w)
Z = 75;
R = 725;
C = 8e-5;
L = 2;
value = Z^2 * ((1/(R^2)) + (w*C - 1/(w*L))^2)-1;
end