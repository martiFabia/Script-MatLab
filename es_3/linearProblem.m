% The Problem: min Cx, s.t. Ax <= b

%Coefficienti funzione obiettivo
C = [ 1 1 -1;
    1 1 0] ;

%Coefficienti vincoli
A =[ 1 1 1;
    -1 -1 0;
    0 -1 0];

b = [4 0 2]' ;

% % solve the scalarized problem with 0 =< alfa =< 1
MINIMA=[ ]; LAMBDA=[ ];
DEG=[ ]; % First column: value of alfa1

for alfa1 = 0 : 0.01 : 1
    [x,fval,exitflag,output,lambda] = linprog(alfa1*C(1,:)+(1-alfa1)*C(2,:),A,b) ;
    MINIMA = [MINIMA;alfa1, x'];
    LAMBDA=[LAMBDA;alfa1,lambda.ineqlin'];
    S=find(lambda.ineqlin <0.01); 
    if size(S,1)> 0.1
        DEG=[DEG;alfa1,x',lambda.ineqlin'];
    end
end

%[MINIMA, LAMBDA]

%alfa, x1,x2,x3, lambda1,lamda2,lamda3
DEG