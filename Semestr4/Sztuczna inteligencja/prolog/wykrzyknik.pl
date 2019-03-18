pp(X,Y,Z) :- p(X), p(Y),!, p(Z).
pp(aa,bb,cc).
p(a).
p(b).
p(c).
p(d).

pp2(X,Y,Z) :- p2(X), p2(Y), p2(Z).
pp2(aa,bb,cc).
p2(a).
p2(b) :- !.
p2(c).
p2(d).

pp3(X,Y,Z) :- p3(X), p3(Y), p3(Z).
pp3(aa,bb,cc).
p3(a).
p3(b) :- fail.
p3(c).
p3(d).


