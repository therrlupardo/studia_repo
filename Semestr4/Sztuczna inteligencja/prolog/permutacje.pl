perm([],[]).
perm(L2, [G|O]) :- usun(G, L2, L), perm(L, O).
usun(E, [E|O], O).
usun(E, [G|O], [G|O1]) :- usun(E, O, O1).
