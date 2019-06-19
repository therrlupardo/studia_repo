function ret = gestosc(x, sigma, ny)
ret = 1 / (sigma * sqrt(2*pi));
wyk = -(x-ny)*(x-ny) / (2*sigma*sigma);
ret = ret * exp(wyk);
end