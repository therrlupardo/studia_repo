function [value] = compute_impedance( omega )

t = 5000;
value = (omega^1.43 + omega^1.14)-1000*t;
end
