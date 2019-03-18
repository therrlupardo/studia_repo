lel1([],0).
lel1([_|O], N) :- lel1(O, N1), N is N1+1.

lel2(L,N) :- pom(L, 0, N).
pom([],N,N).
pom([_|O], N1, N):- N2 is N1+1, pom(O, N2, N).

