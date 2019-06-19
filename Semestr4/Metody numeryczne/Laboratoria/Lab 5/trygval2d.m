function [ FF ] = trygval2d( XX,YY,p )


x=reshape(XX,[],1);
y=reshape(YY,[],1);

M = sqrt(size(p,1))-1;
N=M;

xx = x * ones(1,M+1);
mm = ones(size(x,1),1)*(0:M);
yy = y * ones(1,N+1);
nn = ones(size(y,1),1)*(0:N);

xm=cos(xx.*mm*pi/max(max(XX)));
yn=cos(yy.*nn*pi/max(max(YY)));

pr = reshape(p,M+1,N+1);
f = diag(xm*pr'*yn');

FF=reshape(f',sqrt(size(f,1)),sqrt(size(f,1)));
end

