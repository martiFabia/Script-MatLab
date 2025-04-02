global Q c A b eps; 

%% data
%hessiana
Q = [ 2 -1 0 ;-1 2 1; 0 1 0 ] ;
c = [ -3 ; -4; 0] ;

%vincoli, modificarli in modo che siano <= e NON >
A = [2 1 1;-1 0 0;0 -1 0;0 0 -1 ];
b = [ 20; 0 ; -3; -4 ];

eig(Q)

delta = 10^(-3) ;
tau = 0.5 ;
eps1 = 1 ;
x0 = [2;4;5];

%% barrier method
x = x0; 
eps = eps1 ;
m = size(A,1) ;
SOL=[]
iter=1;
while true
    [x,pval] = fminunc(@logbar,x);
    gap = m*eps;
    SOL=[SOL;iter, eps,x',gap,pval];
    if gap < delta
        break
    else
        eps = eps*tau;
        iter=iter+1;
    end
end
fprintf('\t ITER \t eps \t x(1) \t x(2) \t x(3) \t gap \t pval \n\n');
SOL

%% logarithmic barrier function
function v = logbar(x) 
    global Q c A b eps
    v = 0.5*x'*Q*x + c'*x ;
    for i = 1 : length(b)
        v = v - eps*log(b(i)-A(i,:)*x) ;
    end
end