load trajektoria2
plot3(x,y,z, 'o');
title("Aproksymacja trajektorii a rzeczywista trajektoria");
xlabel("X");
ylabel("Y");
zlabel("Z");
grid on
axis equal

hold on;
N = 60;
xa = aprox_tryg(N, n,x);
ya = aprox_tryg(N, n,y);
za = aprox_tryg(N, n,z);
plot3(xa, ya, za, 'lineWidth', 4);
saveas(gcf, '171619_Buchajewicz_zad7.png');

hold off;
errv = [];
M = size(n, 2);
for N=1:71
    xa = aprox_tryg(N, n,x);
    ya = aprox_tryg(N, n,y);
    za = aprox_tryg(N, n,z);
    
    errx = sqrt(sum((x-xa).^2))/M;
    erry = sqrt(sum((y-ya).^2))/M;
    errz = sqrt(sum((z-za).^2))/M;
    errv = [errv, errx+erry+errz];
end
figure();
semilogy(errv);
title("Wykres bledu aproksymacji");
xlabel("N");
ylabel("Blad");
grid();
saveas(gcf, '171619_Buchajewicz_zad7_b.png');


figure()
title("Wykres po przyblizeniu");
xlabel("X");
ylabel("Y");
zlabel("Z");
plot3(x,y,z, 'o');
grid on
axis equal
hold on
N_ = 1;
eps = 10^-10;
for N=1:300
    xa = aprox_tryg(N, n,x);
    ya = aprox_tryg(N, n,y);
    za = aprox_tryg(N, n,z);
    
    errx = sqrt(sum((x-xa).^2))/M;
    erry = sqrt(sum((y-ya).^2))/M;
    errz = sqrt(sum((z-za).^2))/M;
    err = errx+erry+errz;
    if err <= eps
        N_=N;
        break
    end
end
N_
xa = aprox_tryg(N_, n,x);
ya = aprox_tryg(N_, n,y);
za = aprox_tryg(N_, n,z);
plot3(xa, ya, za, 'lineWidth', 4);
title("Wykres po automatycznym przyblizeniu");
xlabel("X")
ylabel("Y")
zlabel("Z")
saveas(gcf, '171619_Buchajewicz_zad7_c.png');

