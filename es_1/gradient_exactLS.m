Q=[4 1 0 2;1 2 0 0;0 0 4 2;2 0 2 8]

c= [-2 8 6 4]';

disp('Eigen values of Q')
eig(Q)

x0=[1 0 0 1]';
Tolerance=10^(-3);

x=x0;

X=[];

for ITER=1:1000
    v=0.5*x'*Q*x+c'*x;
    g=Q*x+c;
    X=[X;ITER,x',v,norm(g)];

    if norm(g)<Tolerance
        break
    end

    d=-g;
    t=norm(g)^2/(d'*Q*d);
    x=x+t*d;
end

disp('Optimal solution')
x
disp('optimal value')
v
disp('gradient norm at the solution')
norm(g)

disp('Iterations')
ITER

fprintf('\t iter \t x1 \t x2 \t x3 \t x4 \t pval \t norm \n');
X(24:26,:)


%%riprova se x coincide
%x=-inv(Q)*c