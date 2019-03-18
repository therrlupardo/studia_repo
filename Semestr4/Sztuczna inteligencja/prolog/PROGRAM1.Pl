posiada(jan, auto).
posiada(ewa, radio).
posiada(tomasz, konsola).
posiada(monika, auto).
posiada(jan, radio).
ma_dostep(monika, konsola).
ma_dostep(monika, radio).
ma_dostep(monika, ksiazki).
lubi(ewa, radio).
lubi(monika, ksiazki).
lubi(tomasz, konsola).
lubi(ewa, konsola).
  
lubi(_, auto).
  
korzysta(ewa, plyty).
korzysta(X,Y) :- posiada(X,Y), lubi(X,Y).
korzysta(X,Y) :- ma_dostep(X,Y), lubi(X,Y).
