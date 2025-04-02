%matrice C
C=[-1 0 2 3;1 -1 0 1;2 1 1 0;4 2 2 -1 ]

[m, n] = size(C);

% Obiettivo: minimizza v (ultima variabile)
c = [zeros(m,1); 1]; 

% Vincoli Ax <= b
A = [C', -ones(n,1)];
b = zeros(n,1);

% Vincolo di somma delle probabilità = 1
Aeq = [ones(1,m), 0];
beq = 1;

% Limiti inferiori (probabilità ≥ 0, v non limitato)
lb = [zeros(m,1); -inf];

% === PRIMA SOLUZIONE ===
[sol1, Val, ~, ~, lambda1] = linprog(c, A, b, Aeq, beq, lb, []);

x1 = sol1(1:m);     % strategia mista giocatore 1
v = Val;            % valore del gioco
y1 = lambda1.ineqlin; % strategia duale (giocatore 2)

fprintf('\n--- Soluzione 1 ---\n');
disp('x1 (strategia P1):'); disp(x1');
disp('v (valore del gioco):'); disp(v);

% === TROVA ALTRE SOLUZIONI OTTIME ===
num_soluzioni = m;   % quante strategie alternative vuoi trovare
soluzioni = x1';     % salva la prima soluzione
obiettivi = eye(m);  % minimizzeremo x(1), x(2), ..., x(m)

for k = 1:num_soluzioni-1
    c_alt = [obiettivi(:,k); 0];  % cambia obiettivo per spingere verso strategia diversa
    Aeq_alt = [Aeq; c'];          % aggiungi vincolo sul valore del gioco
    beq_alt = [beq; v];
    
    [sol_alt, ~, flag] = linprog(c_alt, A, b, Aeq_alt, beq_alt, lb, []);
    
    if flag == 1
        x_alt = sol_alt(1:m);
        fprintf(['\n--- Soluzione alternativa ', num2str(k+1), ' ---\n']);
        disp('x (strategia P1):'); disp(x_alt');
        soluzioni = [soluzioni; x_alt'];
    else
        fprintf(['\nNessuna soluzione trovata per obiettivo ', num2str(k), '\n']);
    end
end

% === MOSTRA TUTTE LE STRATEGIE TROVATE ===
fprintf('\n=== Tutte le strategie Nash ottime trovate ===\n');
disp(soluzioni);

