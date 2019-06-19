function [xvect,xdif,fx,it_cnt]=bisect(l,r,eps,fun)
c = (l+r)/2;
xvect = [];
xdif = [];
it_cnt = 0;
    for i = 1:1000
        tmpc = c;
        c = (l + r)/2;
        xvect = [xvect, c];
        it_cnt = it_cnt+1;
        if abs(feval(fun, c)) < eps || abs(r-l) < eps
            break
        elseif feval(fun, c)*feval(fun, l) < 0
            r = c;
        else
            l = c;
        end  
        xdif = [xdif, abs(tmpc-c)];     
    end

    fx = c;
end

