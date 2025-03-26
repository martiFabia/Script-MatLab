Q1 = [2 0; 0 0];
Q2 = [0 0; 0 2];

c1 = [0 0]';
c2 = [-1 0]';
A = [-1 -1];
b = -1;

% solve the scalarized problem with  alfa1 in [0,1] 

MINIMA=[ ]; % First column: value of alfa1 

LAMBDA=[ ]; % First column: value of alfa1

for alfa1 = 0.01 : 0.001 : 1
[x,fval,exitflag,output,lambda] = quadprog(alfa1*Q1+(1-alfa1)*Q2,alfa1*c1+(1-alfa1)*c2,A,b); 
MINIMA=[MINIMA; alfa1 x'];
LAMBDA=[LAMBDA;alfa1,lambda.ineqlin'];
end

  plot(MINIMA(:,2),MINIMA(:,3), 'r*')
 