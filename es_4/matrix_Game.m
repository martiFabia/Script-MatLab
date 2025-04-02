
%Scrivere matrice C
C=[-1 0 2 3;1 -1 0 1;2 1 1 0;4 2 2 -1 ]

m = size(C,1);
n = size(C,2);
c=[zeros(m,1);1];

A= [C', -ones(n,1)]; 
b=zeros(n,1); 
Aeq=[ones(1,m),0]; 
beq=1;
lb= [zeros(m,1);-inf]; 
ub=[ ];

[sol,Val,exitflag,output,lambda] = linprog(c, A,b, Aeq, beq, lb, ub);
%probab. con cui il P1 sceglie le sue strategie
x = sol(1:m)

%probab. con cui il P2 sceglie le sue strategie
y = lambda.ineqlin

%valore ottimale del gioco v
Val

