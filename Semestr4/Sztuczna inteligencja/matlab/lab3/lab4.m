% dostaje sie na poczatku zajec ponizszy fragment
% sa to prawdopodobienstwa wystapienia danych wydarzen,
% jak dobrze pamietam zachorowania na jakas chorobe, ale to
% nie ma zadnego znaczenia
clear;

f=1; %false
t=2; %true

% nie wiem jak długo będzie dostępne, ale rysunek poglądowy https://eti.pg.edu.pl/documents/176468/29756687/bayes_wiele_zadan.pdf
% ogólnie chodzi o prawdopodobieństwo wartunkowe, np. pPM oznacza P(P|M), pMGR oznacza P(M|G,R)
% z tego co widziałem są zadania typu policz P(G|P) (to) i chyba P(~C|R), albo coś tego typu.

pG(t)=0.04; 
pG(f)=1-pG(t);

pR(t)=0.10; 
pR(f)=1-pR(t);

pBG(t,t) =0.80;
pBG(t,f) =0.02;
pBG(f,t) =1-pBG(t,t);
pBG(f,f) =1-pBG(t,f);

pCB(t,t)=0.85;
pCB(t,f)=0.25;
pCB(f,t)=1-pCB(t,t);
pCB(f,f)= 1-pCB(t,f);

pPM(t,t)=0.75;
pPM(t,f)=0.50;
pPM(f,t)=1-pPM(t,t);
pPM(f,f)= 1-pPM(t,f);

pUR(t,t)=0.40;
pUR(t,f)=0.25;
pUR(f,t)=1-pUR(t,t);
pUR(f,f)= 1-pUR(t,f);

pMGR(t,t,t) = 0.90;
pMGR(t,f,t) =0.75;
pMGR(t,t,f) =0.35;
pMGR(t,f,f) =0.25;
pMGR(f,t,t) =1-pMGR(t,t,t);
pMGR(f,f,t) =1-pMGR(t,f,t);
pMGR(f,t,f) =1-pMGR(t,t,f);
pMGR(f,f,f) =1-pMGR(t,f,f);

% koniec czesci otrzymanej na zajeciach, reszta do napisania samodzielnie. 
% ! kazdy dostaje jedna z wersji zadania!

% 1. Wyznaczenie lacznego rozkladu prawdopodobienstwa (wypelnienie siedmiowymiarowej tablicy)
% ogólnie 7-wymiarowa tablica prawdopodobieństw danych wydarzeń, generuje się wszystko i mnoży jak poniżej

for b = 1:2 
    for c = 1:2
        for g = 1:2
            for m = 1:2
                for p = 1:2
                    for r = 1:2
                        for u = 1:2
                            Placzne(b,c,g,m,p,r,u) = pG(g) * pR(r) * pBG(b,g) * pCB(c,b) * pUR(u,r) * pPM(p,m) * pMGR(m,g,r); 
                        end
                    end
                end
            end
        end
    end
end

% 2. Sprawdzenie czy suma wartosci w tablicy lacznego rozkladu wynosi 1
% sumowanie powyższej tablicy. Jak wiadomo, suma prawdopodobieństw wszystkich możliwych wydarzeń musi być równa 1
% jeśli nie jest, to coś zepsute.
if sum(sum(sum(sum(sum(sum(sum(Placzne))))))) == 1
    disp('Correct input');
else
    disp('Incorrect input!');
end

% 3. Wyznaczenie zadanych prawdopodobienstw metoda analityczna
% Wyliczanie dokładnej wartości P(G|P) (metoda analityczna)
% tu się robi trudniej, ale ogólnie liczymy sumę prawdopodobieństw wydarzeń, w których G i P jednocześnie prawdziwe
pGP = 0;
for b = 1:2 
    for c = 1:2
        for m = 1:2
            for r = 1:2
                for u = 1:2
                    pGP = pGP + Placzne(b,c,2,m,2,r,u);
                end
            end
        end
    end
end
% jak wyżej, ale tylko P prawdziwe
pP = 0;
for b = 1:2 
    for c = 1:2
        for g = 1:2
            for m = 1:2
                for r = 1:2
                    for u = 1:2
                        pP = pP + Placzne(b,c,g,m,2,r,u);
                    end
                end
            end
        end
    end
end
% prawdopodobieństwo warunkowe P(G|P)
pGifP = pGP/pP;

% 4. Wyznaczenie zadanych prawdopodobienstw metoda Monte Carlo
% to jest najtrudniejsza część, trzeba metodą Monte Carlo obliczyć przybliżone prawdopodobieństwo
% zdarzenia z treści zadania, nanieść je na wykres i porównać do wartości obliczonej analitycznie powyżej

hold on
k = 10000; % ilość obiegów pętli

for i=1:1000
    plot([1 1000], [pGifP pGifP]); % rysowanie prostej poziomej, prawdopodobieństwo analityczne

    % poniżej wyznaczanie wektorów przykładowych k wydarzeń, zgodnych z prawdopodobieństwem
    % dla przykłądu:
    g = rand(1,k) < pG(2);
    % rand(1,k) losuje wektor 1 do k liczb z przedziału od 0 do 1
    % chcemy mieć w g wydarzenia binarne z prawdopodobieństwem zgodnym z podanym wyżej
    % więc jeśli porównamy wylosowaną wartość z prawdopodobieństwem, to z tym właśnie prawdopodobieństwem
    % będzie ona mniejsza od niego. Wtedy wstawimy do wektora 1
    r = rand(1,k) < pR(2);

    % tu jest podobnie jak wyżej, ale aby obliczyć prawdopodobieństwo P(M|G,R) potrzebujemy więcej wartości,
    % ponieważ interesują nas wszystkie możliwości otrzymania M=true
    % wejściowe G,R nie mają znaczenia, więc trzeba uwzględnić zarówno true jak i false
    mgr = rand(1,k) < pMGR(2,2,2); % wszystkie prawdziwe
    mngr = rand(1,k) < pMGR(2,1,2); % m,r prawda; g false
    mgnr = rand(1,k) < pMGR(2,2,1); % m, g true; r false
    mngnr = rand(1,k) < pMGR(2,1,1); % m true; g,r false
    % poniższa linia jest kluczem do obliczeń
    % po matematycznemu twierdzenie Beyes'a
    m = (mgr&g&r)|(mngr&~g&r)|(mgnr&g&~r)|(mngnr&~g&~r); 
    
    % poniżej to samo jak wyżej, tylko dla p
    pm = rand(1,k) < pPM(2,2);
    pnm = rand(1,k) < pPM(2,1);
    p = (pm&m)|(pnm&~m);

    % prawdopodobieństwo dla powyższych danych
    % suma iloczynu binarnego wartości g i p, suma wartości wektoru p
    % średnia ~= prawdopodobieństwo
    P = sum(g&p)/sum(p);
    disp(i);
    % wyniki mają być uśrednione, wtedy można zauważyć, że wraz ze zwiększeniem ilości iteracji wzrasta dokładność
    % przybliżenia
    if i == 1
        srednia(i) = P;
    else
        srednia(i) = srednia(i-1) + (P - srednia(i-1))/i;
    end
end
plot(1:1000, srednia); % wyświetlenie wykresu metody Monte Carlo
