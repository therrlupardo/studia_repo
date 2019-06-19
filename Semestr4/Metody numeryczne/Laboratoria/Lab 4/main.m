clc
clear all
close all

a = 1;   
b = 60000;

[xvect, xdif, fx, it_cnt] = bisect(a,b,1e-3,@compute_impedance);

figure();
plot(xvect);
title('Wykres wartosci - metoda bisekcji - pewien algorytm');
xlabel('Iteracje');
ylabel('Wartosc');
saveas(gcf, 'wartosci_bisekcja_pa.png');

figure();
semilogy(xdif);
title('Wykres roznic - metoda bisekcji - pewien algorytm');
xlabel('Iteracje');
ylabel('Roznica wartosci');
saveas(gcf, 'roznice_wartosci_bisekcja_pa.png')


a = 1;   
b = 50;

[xvect, xdif, fx, it_cnt] = bisect(a,b,1e-12,@compute_frequency);

figure();
plot(xvect);
title('Wykres wartosci - metoda bisekcji - obwod rezonansowy');
xlabel('Iteracje');
ylabel('Wartosc');
saveas(gcf, 'wartosci_bisekcja_obwod.png');

figure();
semilogy(xdif);
title('Wykres roznic - metoda bisekcji - obwod rezonansowy');
xlabel('Iteracje');
ylabel('Roznica wartosci');
saveas(gcf, 'roznica_wartosci_bisekcja_obwod.png');

a = 1;   
b = 50;

[xvect, xdif, fx, it_cnt] = bisect(a,b,1e-12,@compute_time);

figure();
plot(xvect);
title('Wykres wartosci - metoda bisekcji - lot rakiety');
xlabel('Iteracje');
ylabel('Wartosc');
saveas(gcf, 'wartosci_bisekcja_lot_rakiety.png');

figure();
semilogy(xdif);
title('Wykres roznic - metoda bisekcji - lot rakiety');
xlabel('Iteracje');
ylabel('Roznica wartosci');
saveas(gcf, 'roznica_wartosci_bisekcja_lot_rakiety.png');


a = 1;   
b = 60000;

[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-3,@compute_impedance);

figure();
plot(xvect);
title('Wykres wartosci - metoda siecznych - pewien algorytm');
xlabel('Iteracje');
ylabel('Wartosc');
saveas(gcf, 'wartosci_sieczne_pa.png');

figure();
semilogy(xdif);
title('Wykres roznic - metoda siecznych - pewien algorytm');
xlabel('Iteracje');
ylabel('Roznica wartosci');
saveas(gcf, 'roznica_wartosci_sieczne_pa.png');


a = 1;   
b = 50;

[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-12,@compute_frequency);

figure();
plot(xvect);
title('Wykres wartosci - metoda siecznych - obwod rezonansowy');
xlabel('Iteracje');
ylabel('Wartosc');
saveas(gcf, 'wartosci_sieczne_obwod.png');

figure();
semilogy(xdif);
title('Wykres roznic - metoda siecznych - obwod rezonansowy');
xlabel('Iteracje');
ylabel('Roznica wartosci');
saveas(gcf, 'roznica_wartosci_sieczne_obwod.png');

a = 1;   
b = 50;

[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-12,@compute_time);

figure();
plot(xvect);
title('Wykres wartosci - metoda siecznych - lot rakiety');
xlabel('Iteracje');
ylabel('Wartosc');
saveas(gcf, 'wartosci_sieczne_lot_rakiety.png');

figure();
semilogy(xdif);
title('Wykres roznic - metoda siecznych - lot rakiety');
xlabel('Iteracje');
ylabel('Roznica wartosci');
saveas(gcf, 'roznica_wartosci_sieczne_lot_rakiety.png');
