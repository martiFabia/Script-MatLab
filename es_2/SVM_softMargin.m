%% data 

A=[8 1.5
    6 2
    7 0.5
    2.76 0.46
    0.97 8.23
    9.5 0.34
    4.38 3.81
    1.86 4.89
    2.75 6.75
    6.5 1.5];

B=[10 2.4
    5 2
    7.51 2.55
    5.05 7
    9 9.6
    8.40 2.54
    8.14 2.43
    9.3 3.45
    6.16 5
    3.5 8.5];


nA = size(A,1);
nB = size(B,1);

% training points
T = [A ; B]; 

%% Linear SVM - dual model (soft margin) - Exercise 5.4

% define the problem
C = 30 ;

y = [ones(nA,1) ; -ones(nB,1)]; % labels
l = length(y);
Q = zeros(l,l);
for i = 1 : l
    for j = 1 : l
        Q(i,j) = y(i)*y(j)*(T(i,:))*T(j,:)' ;
    end
end

% solve the problem
la = quadprog(Q,-ones(l,1),[],[],y',0,zeros(l,1),C*ones(l,1));

% compute vector w
w = zeros(2,1);
for i = 1 : l
   w = w + la(i)*y(i)*T(i,:)'; 
end

% compute scalar b
indpos = find(la > 0.001);
ind = find(la(indpos) < C - 10^(-3));
i = indpos(ind(1));
b = 1/y(i) - w'*T(i,:)';


la 
w
b


for i=1:l
    if (la(i) > C-0.001 & la(i)<C+0.001)
        xi(i)=1 - y(i)*(T(i,:)*w+b);
    else
        xi(i)=0;
    end
end
xi'