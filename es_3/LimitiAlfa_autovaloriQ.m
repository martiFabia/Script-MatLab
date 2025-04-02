syms alpha lambda

% Matrice Hessiana
Q = [2-2*alpha, alpha; alpha, 4-4*alpha];
lambda_values = eig(Q);

sol = solve(lambda_values >=  0, alpha, 'Real', true);

disp('Intervallo di alpha1 per cui Q è definita positiva:');
disp(sol);
disp(double(sol))

Q = [2-2*0.8, 0.8; 0.8, 4-4*0.8];
eig(Q)



