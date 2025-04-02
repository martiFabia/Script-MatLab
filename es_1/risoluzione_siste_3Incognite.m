% Matrice dei coefficienti
A = [2 -4 -2; -4 8 4; -2 4 2];

% Vettore dei termini noti
b = [2; -4; -2];

% Risoluzione del sistema
x = inv(A)*b;

% Visualizza il risultato
disp('Soluzione del sistema:');
disp(x);

disp('RANK A:');
rank(A)
disp('RANK A,-b:');
rank(A,-b)
