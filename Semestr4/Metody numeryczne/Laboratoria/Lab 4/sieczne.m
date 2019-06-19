function [xvect,xdif,fx,it_cnt]=sieczne(l,r,eps,fun)
    x0 = l;
    x1 = r;
    xvect = [];
    xdif = [];
    it_cnt = 0;
    for i=1:1000
        tmpx = x1;
        x2 = x1 - (feval(fun, x1)*(x1-x0))/(feval(fun, x1) - feval(fun, x0));
        xvect = [xvect, x2];
        xdif = [xdif, abs(tmpx-x2)];
        it_cnt = it_cnt+1;
        if abs(feval(fun, x2)) < eps
            break    
        end
        x0 = x1;
        x1 = x2;
    end
    fx = x1;
end