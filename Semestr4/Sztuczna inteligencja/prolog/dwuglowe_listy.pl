maxel([X], X).
maxel([G1,G2|O], X) :- G1 >= G2, maxel([G1|O], X).
maxel([G1,G2|O], X) :- G1 < G2, maxel([G2|O], X).
