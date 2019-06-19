% Zadanie E
%------------------
clc
clear all
close all

% przyk?ad dzia?ania funkcji tril, triu, diag:
% Z = rand(4,4)
% tril(Z,-1) 
% triu(Z,1) 
% diag(diag(Z))


N = [500, 1000, 3000, 6000, 12000];
density = 10;
d = 0.85;



normres = [];
for i = 1:5
[Edges] = generate_network(N(i), density);
    I = speye(N(i));
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    L = sum(B);
    A = speye(N(i))./L;
    b = ones(N(i), 1).* ((1-d)/N(i));
    M = sparse(I - d*B*A);
    
    r = ones(N(i), 1);
    D = diag(diag(M));
    L = tril(M, -1);
    U = triu(M, 1);
    
    res = 1;
    iter(i) = 1;
    k = 1;
    tic
    while norm(res) > 1e-14
        if N(i)==500
            normres(k) = norm(res);
            k = k + 1;
        end
        r = -(D+L)\(U*r) + (D+L)\b;
        res = M*r-b;
        iter(i) = iter(i) + 1;
    end
    czas_GS(i) = toc;
    
end

figure();
plot(czas_GS);
title('Wykres czasu metody Gaussa-Seidla w zaleznosci od N');
xlabel('Wielkosc macierzy N');
ylabel('Czas [s]');
saveas(gcf, 'zadF_1.png');

figure();
plot(iter);
title('Wykres liczby iteracji metody Gaussa-Seidla w zaleznosci od N');
xlabel('Wielkosc macierzy N');
ylabel('Liczba iteracji');

saveas(gcf, 'zadF_2.png');

figure();
semilogy(normres);
title('Wykres normy residuum metody Gaussa-Seidla w zaleznosci od N');
xlabel('Ilosc iteracji');
ylabel('Norma residuum');
saveas(gcf, 'zadF_3.png');



%------------------


