%% Data
alpha = 0.1;
gamma = 0.8;
tbar = 1;
x0 = [2;5];
tolerance = 10^(-5) ;

X=[ ];
ITER = 0 ;
x = x0;

while true
    [v, g] = f(x);
    X=[X;ITER,x(1),x(2),v,norm(g)];

    % stopping criterion
    if norm(g) < tolerance
        break
    end
    d = -g; % search direction
    t = tbar ; % Armijo inexact line search

    while f(x+t*d) > v + alpha*g'*d*t
        t = gamma*t ;
    end
    
    x = x + t*d ; % new point
    ITER = ITER + 1 ;
end

disp('optimal solution')
%optimal solution
x
%valore f(x) con x 
v
%gradient norm evaluated at the final point 
norm(g)
ITER
X(end-2:end, :)

function [v, g] = f(x)
    p=exp(x(1)^2-2*x(2)+x(2)^2-x(1)*x(2));
    v = p;
    g = [(2*x(1)-x(2))*p;
        (-2+2*x(2)-x(1))*p];
end

