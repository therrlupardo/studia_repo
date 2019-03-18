mdon(_,0,1).
mdon(M,N,Y) :- N>0, N1 is N-1, mdon(M,N1,Y1), Y is M * Y1.
