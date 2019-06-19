clc
clear all
close all

% odpowiednie fragmenty kodu mo?na wykona? poprzez znazaczenie i wci?ni?cie F9
% komentowanie/ odkomentowywanie: ctrl+r / ctrl+t

% Zadanie A
%------------------
N = 10;
density = 3; % parametr decyduj?cy o gestosci polaczen miedzy stronami
[Edges] = generate_network(N, density);
%-----------------

% Zadanie B
%------------------
% generacja macierzy I, A, B i wektora b
% ...
d = 0.85;
I = speye(N);
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
L = sum(B);
A = speye(N)./L;

b = ones(N, 1).* ((1-d)/N);

save zadB A B I b
%-----------------

% Zadanie C
%-----------------
M = sparse(I - d*B*A);
r = M\b;
save zadC r


