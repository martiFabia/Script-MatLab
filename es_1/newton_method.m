
alpha=0.1;
gamma=0.9;
tbar=1;
x0=[0;0];
tolerance=10^(-3);

x=x0;
X=[];
for ITER=1:100
    [v,g,H]=f(x);
    X=[X;ITER,x',v,norm(g)];

    if norm(g)<tolerance
        break 
    end

    d=-inv(H)*g;
    t=tbar;
    while (f(x+t*d)>f(x)+alpha*t*d'*g)
        t=gamma*t;
    end
    x=x+t*d;
end

X(end-2:end,:)

function [v,g,H]=f(x)

v=2*x(1)^4+3*x(2)^4+2*x(1)^2+4*x(2)^2+x(1)*x(2)-3*x(1)-2*x(2);
g=[8*x(1)^3+4*x(1)+x(2)-3;
    12*x(2)^3+8*x(2)+x(1)-2];
H=[24*x(1)^2+4 1;
    1 36*x(2)^2+8];
end

