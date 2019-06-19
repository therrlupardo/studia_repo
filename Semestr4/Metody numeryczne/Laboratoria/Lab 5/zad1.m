K=[5,15,25,35];

[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(1));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu lazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('zbierane wartosci probek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'zadanie1_k=5.png')


[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(2));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu lazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('zbierane wartosci probek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'zadanie1_k=15.png')


[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(3));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu lazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('zbierane wartosci probek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'zadanie1_k=25.png')


[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(4));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu lazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('zbierane wartosci probek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'zadanie1_k=35.png')
