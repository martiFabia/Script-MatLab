
data = [-3.0000 6
        -2.8000 8
        -2.6000 8.5
        -2.0000 17
        -1.8000 11.48
        -1.6000 14.10
        -1.4000 16.82
        -1.2000 16.15
        -1.0000 11.68
        -0.8000 6.00
        -0.6000 7.82
        -0.4000 2.82
        -0.2000 2.71
        0 1
        0.2000 -1
        0.4000 -3.84
        0.6000 -4.71
        1.0000 -7.33
        1.2000 -13.64
        1.4000 -15.26
        1.6000 -14.87
        1.8000 -9.92
        2.0000 -10.50
        2.2000 -7.72
        2.4000 -12.5
        2.6000 -10.26
        2.8000 -7
        3.0000 -2];

x = data(:,1) ;
y = data(:,2) ;
l = length(x) ;

%variabili da IMPOSTARE!!
epsilon = 3.5 ;
C = 8;

X = zeros(l,l);

for i = 1 : l
    for j = 1 : l
        X(i,j) = kernel(x(i),x(j)) ;
    end
end
Q = [ X -X ; -X X ];
c = epsilon*ones(2*l,1) + [-y;y];
sol = quadprog(Q,c,[],[],[ones(1,l) -ones(1,l)],0,zeros(2*l,1),C*ones(2*l,1));
lap = sol(1:l);
lam = sol(l+1:2*l);

% compute b
ind = find(lap > 1e-3 & lap < C-1e-3);

if isempty(ind)==0
    i = ind(1);
    b = y(i) - epsilon;
    for j = 1 : l
        b = b - (lap(j)-lam(j))*kernel(x(i),x(j));
    end
else
    ind = find(lam > 1e-3 & lam < C-1e-3);
    i = ind(1);
    b = y(i) + epsilon ;
    for j = 1 : l
        b = b - (lap(j)-lam(j))*kernel(x(i),x(j));
    end
end

z = zeros(l,1); % find regression and epsilon-tube
for i = 1 : l
    z(i) = b ;
    for j = 1 : l
        z(i) = z(i) + (lap(j)-lam(j))*kernel(x(i),x(j));
    end
end
zp = z + epsilon ;
zm = z - epsilon ;

% find support vectors
sv = [find(lap > 1e-3);find(lam > 1e-3)];
sv = sort(sv);

% plot the solution
%plot(x,y,'b.',x(sv),y(sv),'ro',x,z,'k-',x,zp,'r-',x,zm,'r-'); 

%Indexes of support vectors, support vectors, lambda_-,lambda_+
disp('Support vectors')
[sv,x(sv),y(sv),lam(sv),lap(sv)] 

b

%%kernel function DA CAMBIARE IN BASE AL PROBLEMA
function v = kernel(x,y)
    v = exp(-norm(x-y)^2);
end

