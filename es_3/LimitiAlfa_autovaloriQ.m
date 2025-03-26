syms alpha1 lambda

% Definizione della matrice Hessiana
Q = [2*(1 - alpha1), alpha1; alpha1, 4*(1 - alpha1)];

% Calcola gli autovalori
lambda_values = eig(Q);

% Risolvi la condizione di positività degli autovalori
sol = solve(lambda_values >=  0, alpha1, 'Real', true);

% Mostra il risultato
disp('Intervallo di alpha1 per cui Q è definita positiva:');
disp(sol);
disp(double(sol))
