% Zadanie D
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
d = 0.85;
density = 10;

for i = 1:5
    % obliczenia
    [Edges] = generate_network(N(i), density);
    I = speye(N(i));
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    L = sum(B);
    A = speye(N(i))./L;
    b = ones(N(i), 1).* ((1-d)/N(i));
    M = sparse(I - d*B*A);
    tic
    r = M\b;
    czas_Gauss(i) = toc;
end

plot(N, czas_Gauss)
title("Zadanie D - mierzenie czasu metody bezposredniej");
xlabel("Wymiar macierzy N");
ylabel("Czas [s]");
saveas(gcf, 'zadD.png');
%------------------







