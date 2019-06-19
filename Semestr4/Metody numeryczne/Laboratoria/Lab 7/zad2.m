rng(0, 'twister');
N = 10^7;
% prostokaty
tic
    prost_prob = 0;
    h = 5/N;
    xi = 0;
    for j=1:N
        a = gestosc((2*xi + h)/2, 3, 10);
        prost_prob = prost_prob + a*h;
        xi = xi + h;
    end
pr_time = toc;

% trapezy
tic
xi = 0;
    h = 5/N;
    tr_prob = 0;
    for j=1:N
        a = gestosc(xi+h, 3, 10);
        b = gestosc(xi, 3, 10);
        tr_prob = tr_prob + ((a+b)/2)*h;
        xi = xi+h;
    end
    tr_time = toc;
    
% simpson
tic
xi = 0;
    h = 5/N;
    sim_prob = 0;
    for j=1:N
        a = gestosc(xi+h, 3, 10);
        b = gestosc(xi, 3, 10);
        c = gestosc((xi + xi + h)/2, 3, 10);
        sim_prob = sim_prob + (h/6) * (a + b + 4*c);
        xi = xi + h;
    end
sim_time = toc;


% monte carlo
tic
fmax = gestosc(5, 3, 10);
    N1 = 0;
    for j=1:N
        x = 5 * rand();
        y = fmax * rand();
        if y < gestosc(x, 3, 10)
            N1 = N1+1;
        end
    end
    S = fmax * 5;
    prob = N1 / N * S;
mc_time = toc;
% time
x = categorical({'M.Prostokatow', 'M.Trapezow', 'M. Simpsona', 'M. Monte Carlo'});
y = [pr_time, tr_time, sim_time, mc_time];
bar(x, y);
title("Czasy roznych metod");
xlabel("Metoda");
ylabel("Czas");
saveas(gcf, "wykres_czasy.png");