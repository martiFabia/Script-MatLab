Q1 = [0 1; 1 0];
Q2 = [2 0; 0 4] ;
c1=[0 0]';
c2=[0 -2]';

MINIMA=[ ]; SOL=[ ];

for alfa1 = 0 : 0.001 : 1
    eigQalfa1= eig(alfa1*Q1+(1-alfa1)*Q2);
    eigQ=[eigQ;alfa1,eigQalfa1']; % Eigenvalues of the hessian of \psi_alfa1(x)
    if (eigQ > 0.001)
        [x,fval,exitflag,exitflag] = fminunc(@(x) 0.5*x'*(alfa1*Q1+(1-alfa1)*Q2)*x +(alfa1*c1+(1-alfa1)*c2)'*x, [0,0]') ;
        MINIMA=[MINIMA; alfa1 x'];
    else
        [x,fval,exitflag,exitflag] = fminunc(@(x) 0.5*x'*(alfa1*Q1+(1-alfa1)*Q2)*x +(alfa1*c1+(1-alfa1)*c2)'*x, [0,0]') ;
        SOL=[SOL; alfa1 x'];
    end
end
plot(MINIMA(:,2),MINIMA(:,3), 'r*')