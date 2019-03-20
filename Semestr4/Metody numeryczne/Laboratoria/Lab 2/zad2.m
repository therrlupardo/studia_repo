clc;
clear all;
 
a = 5;
r_max = a/3;
n_max = 100;
out_of_bounds = false;
n = 0;
 
Vx = [];
Vy = [];
Vr = [];
Vsurface = [];
Vsum_surfaces = [];
surface = 0;
Vtries = [];
try_no = 0;
while(n<n_max)
    while(true)
        try_no = try_no + 1;
        x = a*rand(1);
        y = a*rand(1);
        r = r_max * rand(1);
        if(x-r > 0 && x+r <= a && y-r>0 && y+r<=a)
            break;
        end
    end
   
    crossing = false;
    for i = 1:n
        distX = (x-Vx(i));
        distY = (y-Vy(i));
        dist = sqrt(distX*distX + distY*distY);
        if(dist < Vr(i) + r && dist > abs(Vr(i) - r))
            crossing = true;
        elseif (dist == Vr(i)+r)
            crossing = true;
        end        
    end
    if (crossing == false)
        n  = n + 1;
        Vtries(n) = try_no;
        try_no = 0;
        Vx(n) = x;
        Vy(n) = y;
        Vr(n) = r;
        Vsurface(n) = pi *r*r;
        Vsum_surface(n) = surface + pi * r*r;
        surface = Vsum_surface(n);
       
        fprintf(1, '%s%5d %s%.3g\r', 'n=', n, 'S=', Vsurface(n));
        pause(0.01);
        axis equal
        plot_circ(x, y, r)
        hold on
    end
end % end while n <= n_max
figure('Name', 'Suma powierzchni');
semilogx(1:n, Vsum_surface);
 
figure('Name', 'Srednia liczba losowan');
loglog(cumsum(Vtries)./(linspace(1,n,n)));
 
function plot_circ(X, Y, R)
    theta = linspace(0,2*pi);
    x = R*cos(theta) + X;
    y = R*sin(theta) + Y;
    plot(x,y)
end