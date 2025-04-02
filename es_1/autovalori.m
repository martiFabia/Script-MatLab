syms x1 x2 x3

% Definizione della funzione
%f = x1^2 - log(x1 + x2);
f=x1^2+x2^-2*x1*x2;

% Calcolo del gradiente (vettore delle derivate prime)
grad_f = gradient(f, [x1, x2]);

% Calcolo della matrice Hessiana (matrice delle derivate seconde)
H_f = hessian(f, [x1, x2]);

% Calcolo degli autovalori della matrice Hessiana
eigenvalues = eig(H_f);

% Visualizzazione dei risultati
disp('Matrice Hessiana:');
disp(H_f);

disp('Autovalori della matrice Hessiana:');
disp(eigenvalues);
