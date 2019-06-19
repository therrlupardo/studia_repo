divp =[];
divt = [];
temppFF = [];
temptFF = [];

[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(5);
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
divp = [divp,max(max(abs(FF)))];
temppFF = FF;
    
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p); 
divt = [divt,max(max(abs(FF)))];
temptFF = FF;

for k=6:45
    [XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
    [x,y,f]=lazik(k);
    
    [p]=polyfit2d(x,y,f);
    [FF]=polyval2d(XX,YY,p);
    divp = [divp,max(max(abs(FF-temppFF)))];
    temppFF = FF;
    
    [p]=trygfit2d(x,y,f);
    [FF] = trygval2d(XX, YY,p); 
    divt = [divt,max(max(abs(FF-temptFF)))];
    temptFF = FF;
end
figure();
plot(5:45,divp);
title('Zbieznosc - interpolacja wielomianowa');
xlabel('Liczba punktow pomiarowych k');
ylabel('Zbieznosc funkcji interpolowanej');
saveas(gcf, 'zadanie2_wiel.png')
figure();
plot(5:45,divt);
title('Zbieznosc - interpolacja trygonometryczna');
xlabel('Liczba punktow pomiarowych k');
ylabel('Zbieznosc funkcji interpolowanej');
saveas(gcf, 'zadanie2_tryg.png')