function [wsp_wielomianu, x_approx ]=aproksymacjaWiel(n,x,N)

mu = [mean(n) std(n)];
n2 = (n-mu(1))/mu(2);
wsp_wielomianu = polyfit(n2,x,N);
x_approx = polyval(wsp_wielomianu,n2);

end

