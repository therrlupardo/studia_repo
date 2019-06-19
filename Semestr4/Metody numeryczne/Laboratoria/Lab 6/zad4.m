load trajektoria1
plot3(x,y,z, 'o');
title("Aproksymacja trajektorii a rzeczywista trajektoria");
xlabel("X");
ylabel("Y");
zlabel("Z");
grid on
axis equal

hold on;
N = 50;
[~, xa] = aproksymacjaWiel(n,x, N);
[~, ya] = aproksymacjaWiel(n,y, N);
[~, za] = aproksymacjaWiel(n,z, N);
plot3(xa, ya, za, 'lineWidth', 4);
saveas(gcf, '171619_Buchajewicz_zad4.png');