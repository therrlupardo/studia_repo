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
[~, xa] = aproksymacjaWiel(n,x, N);
[~, ya] = aproksymacjaWiel(n,y, N);
[~, za] = aproksymacjaWiel(n,z, N);
plot3(xa, ya, za, 'lineWidth', 4);
saveas(gcf, '171619_Buchajewicz_zad5.png');

hold off;
err = [];
M = size(n, 2);
for N=1:71
    [~, xa] = aproksymacjaWiel(n,x, N);
    [~, ya] = aproksymacjaWiel(n,y, N);
    [~, za] = aproksymacjaWiel(n,z, N);
    
    errx = sqrt(sum((x-xa).^2))/M;
    erry = sqrt(sum((y-ya).^2))/M;
    errz = sqrt(sum((z-za).^2))/M;
    err = [err, errx+erry+errz];
end
figure();
semilogy(err);
title("Wykres bledu aproksymacji");
xlabel("N");
ylabel("Blad");
grid();
saveas(gcf, '171619_Buchajewicz_zad5_b.png');