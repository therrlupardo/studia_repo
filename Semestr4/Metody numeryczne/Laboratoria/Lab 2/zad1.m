clc
clear all
N=7;
% A
edges = [1 1 2 2 2 3 3 3 4 4 5 5 6 6 7;
         4 6 3 4 5 5 6 7 5 6 4 6 4 7 6];
% B
d = 0.85;
I = speye(N);
B = sparse(edges(2,:), edges(1,:), 1, N, N);
L = sum(B);
A = speye(N)./L;
 
b = ones(N, 1).* ((1-d)/N);
 
% C
M = sparse(I - d*B*A);
r = M\b;
bar(r);
 