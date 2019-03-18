silnia(0,1).
silnia(X, N) :- X > 0, X1 is X-1, silnia(X1,N1), N is X * N1.
