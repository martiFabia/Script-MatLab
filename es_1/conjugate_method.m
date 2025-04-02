Q=[6 1 0 2;1 2 0 0;0 0 4 2;2 0 2 4];

c=[1 -1 2 -3]';
disp('Eigenvalues of Q: ')
eig(Q)

x0=[1,0,0,0]';
tolerance = 10^(-6);

% Conjugate Gradient method

% starting point
x = x0;
X=[ ];
for ITER=1:10
    v = 0.5*x'*Q*x + c'*x;
    g = Q*x + c ;

    X=[X;ITER,x',v,norm(g)];
    % stopping criterion
    if norm(g) < tolerance
        break
    end
    
    %   search direction
    if ITER == 1
        d = -g; 
    else
        beta = (g'*Q*d_prev)/(d_prev'*Q*d_prev);
        d = -g + beta*d_prev;
    end
    
    %   step size
    t = (-g'*d)/(d'*Q*d);
    
    %   new point
    x = x + t*d; 
    d_prev = d ; 
end
 X
 norm(g)
 ITER

 %%riprova se x coincide 
 x=-inv(Q)*c