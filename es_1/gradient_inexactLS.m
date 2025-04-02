%% Data
global Q c;

Q = [2 -4 -2;-4 8 4; -2 4 2];
c = [-2 4 2]';
disp('Eigenvalues of Q:')
eig(Q)


alpha = 0.1;
gamma = 0.8;
tbar = 1;
x0 = [-10 8]';
tolerance = 10^(-6) ;

X=[ ];
ITER = 0 ;
x = x0;

while true
    [v, g] = f(x);
    X=[X;ITER,x',v,norm(g)];

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
    global Q c;
    %caso quadratico
    % v=0.5*x'*Q*x + c'*x;
    % g=Q*x+c;

    %caso NON quadratico scrivere funzione obiettivo e gradiente
    % p=exp(x(1)^2-2*x(2)+x(2)^2-x(1)*x(2));
    % v = p;
    % g = [(2*x(1)-x(2))*p;
    %     (-2+2*x(2)-x(1))*p];

    v = 2*x(1)^2 + x(2)^2 - x(1)*x(2) + exp(x(1)+2*x(2)) ;
    g = [4*x(1)-x(2)+exp(x(1)+2*x(2));
        -x(1)+2*x(2)+2*exp(x(1)+2*x(2))];
end

