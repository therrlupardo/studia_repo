%rng(0, 'twister');
N=10^5;
N1 = 0;
for j=1:N
    x = 100 * rand();
    y = 100 * rand();
    z = -50 * rand();
    if z > glebokosc(x, y)
        N1 = N1+1;
    end
end
V = 50 * 100 * 100;
prob = N1 / N * V;

disp("Ilosc punktow ponad dnem: " + N1 + "/" + N);
disp("Przyblizona objetosc jeziora: " + prob);