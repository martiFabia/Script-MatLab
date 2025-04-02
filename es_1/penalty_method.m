global A b eps;

% data
A = [2 1 ; -1 -1 ; -1 0 ];
b = [ 4 ; -1 ; 0 ];

% parameters
tau = 0.1 ; 
eps0 = 5 ;
tolerance = 1e-6;

eps = eps0;
x = [4;0];
iter = 1;
SOL=[];

while true
    [x,pval] = fminunc(@p_eps,x);
    infeas = max(A*x-b);

    SOL=[SOL;iter,eps,x',infeas,pval];
    if infeas < tolerance
        break
    else
        eps = tau*eps;
        iter = iter + 1 ;
    end
end

fprintf('\t iter \t eps \t x(1) \t x(2) \t max(Ax-b) \t pval \n');
SOL
%vpa(SOL, 6)


%% penalized function
function v= p_eps(x) 
    global A b eps;
    v = x(1)^2 -log(x(1)+x(2)) ;
    for i = 1 : size(A,1)
        v = v + (1/eps)*(max(0,A(i,:)*x-b(i)))^2 ;
    end
end