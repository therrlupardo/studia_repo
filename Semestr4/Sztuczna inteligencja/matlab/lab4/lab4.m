% przykładowe wykresy
n = -5:0.1:5;
plot(n, hardlim(n));
plot(n, logsig(n));
plot(n, tansig(n));
plot(n, purelin(n));

% jeden neuron
net = newp([-2 2; -2 2], 1, 'purelin');
net.IW {1, 1} = [1, 1];
net.b {1} = -1;
[X1 X2] = meshgrid(-2:0.1:2);
Y = X1;
Y(:) = sim(net, [X1(:)'; X2(:)']);
surf(X1, X2, Y);

% figury pomiędzy prostymi
net = newff([0, 3; 0, 3], [2, 1], {'hardlim', 'hardlim'});
net.IW {1, 1} = [-1, 1; 1, -1];
net.LW {2, 1} = [1, 1];             % od 1 do 2
net.b {1} = [0.5; 0.5];                    % dla 1 warstwy 0.5
net.b {2} = [-1.5];                   % dla 2 warstwy -1.5

[X1 X2] = meshgrid(-2:0.1:2);
Y = X1;
Y(:) = sim(net, [X1(:)'; X2(:)']);
surf(X1, X2, Y);

% punkty w kwadracie
net = newff([0, 3; 0, 3], [4, 1], {'hardlim', 'hardlim'});
net.IW {1, 1} = [0, 1; 0, -1; 1, 0; -1, 0];
net.LW {2, 1} = [1, 1, 1, 1];             % od 1 do 2
net.b {1} = [-1; 2; -1; 2];                    % dla 1 warstwy 0.5
net.b {2} = [-3.5];                   % dla 2 warstwy -1.5

[X1 X2] = meshgrid(-2:0.1:2);
Y = X1;
Y(:) = sim(net, [X1(:)'; X2(:)']);
surf(X1, X2, Y);

% algorytm propagacji wstecznej
X = -1:0.01:1;
Y = sin(3* pi * X).^(2).*sin(pi*X);

% XU + YU = dane uczące
XU = -1:0.05:1; 
YU = sin(3* pi * XU).^(2).*sin(pi*XU);

net = newff([-1 1], [15 1], {'tansig', 'purelin'}, 'trainlm');
net.trainParam.goal = 0.0000001;
net.trainParam.epochs = 500;

net = init(net);
net = train(net, XU, YU);

ynet = sim(net, X);

plot(X, Y, 'r', XU, YU, 'gO', X, ynet, 'b');


% trójkąt(0,5), (4,2), (2,1)
net = newff([0, 3; 0, 3], [3, 1], {'hardlim', 'hardlim'});
net.IW {1, 1} = [-0.75 -1; -0.5 1; 2 1];
net.LW {2, 1} = [1, 1, 1];            
net.b {1} = [5; 0; -5];               
net.b {2} = [-2.5];                   

[X1 X2] = meshgrid(-1:0.1:6);
Y = X1;
Y(:) = sim(net, [X1(:)'; X2(:)']);
surf(X1, X2, Y);