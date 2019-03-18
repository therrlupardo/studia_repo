elem(E, [E|_]).
elem(E, [_|O]) :- elem(E, O).
