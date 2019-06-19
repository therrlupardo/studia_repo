function [value] = compute_time(t)
    g=9.81;
    v=750;
    m0=150000;
    q=2700;
    u = 2000;
    value = exp((v + g*t)/u) - (m0/(m0-q*t));
end