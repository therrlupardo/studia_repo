rng(0, 'twister');
res = [];

for t=1:20
    res = [res,gestosc(t, 3, 10)];
end
figure();
plot(1:20,res);
title('Funkcja gestosci');
xlabel('Punkt');
ylabel('Wartosc');
saveas(gcf, 'wykres_funkcja_gestosci.png')


N = 5:50:10^4;

% prostokaty
err_v = [];
for i=1:size(N,2)
    prost_prob = 0;
    h = 5/N(i);
    xi = 0;
    for j=1:N(i)
        a = gestosc((2*xi + h)/2, 3, 10);
        prost_prob = prost_prob + a*h;
        xi = xi + h;
    end
    err_v = [err_v, abs(prost_prob - P_ref)];
end
figure();
semilogy(err_v);
title('Blad metoda prostokatow');
xlabel('Liczba punktow');
ylabel('Blad');
saveas(gcf, 'metoda_prostokatow_wykres_bledu.png')

% trapezy
err_v = [];
for i=1:size(N,2)
    xi = 0;
    h = 5/N(i);
    tr_prob = 0;
    for j=1:N(i)
        a = gestosc(xi+h, 3, 10);
        b = gestosc(xi, 3, 10);
        tr_prob = tr_prob + ((a+b)/2)*h;
        xi = xi+h;
    end
    err_v = [err_v, abs(tr_prob - P_ref)];
end
figure();
semilogy(err_v);
title('Blad metoda trapezow');
xlabel('Liczba punktow');
ylabel('Blad');
saveas(gcf, 'metoda_trapezow_wykres_bledu.png')


% Simpson
err_v = [];
for i=1:size(N,2)
    xi = 0;
    h = 5/N(i);
    sim_prob = 0;
    for j=1:N(i)
        a = gestosc(xi+h, 3, 10);
        b = gestosc(xi, 3, 10);
        c = gestosc((xi + xi + h)/2, 3, 10);
        sim_prob = sim_prob + (h/6) * (a + b + 4*c);
        xi = xi + h;
    end
    err_v = [err_v, abs(sim_prob - P_ref)];
end
figure();
semilogy(err_v);
title('Blad metoda Simpsona');
xlabel('Liczba punktow');
ylabel('Blad');
saveas(gcf, 'metoda_simpsona_wykres_bledu.png');

% Monte Carlo

err_v = [];
fmax = gestosc(5, 3, 10);
for i=1:size(N,2)
    N1 = 0;
    for j=1:N(i)
        x = 5 * rand();
        y = fmax * rand();
        if y < gestosc(x, 3, 10)
            N1 = N1+1;
        end
    end
    S = fmax * 5;
    prob = N1 / N(i) * S;
    err_v = [err_v, abs(prob - P_ref)];
end
figure();
semilogy(err_v);
title('Blad metoda Monte Carlo');
xlabel('Liczba punktow');
ylabel('Blad');
saveas(gcf, 'metoda_monte_carlo_wykres_bledu.png');

