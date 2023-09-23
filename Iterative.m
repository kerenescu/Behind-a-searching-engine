function R = Iterative(nume, d, eps)
% Functia care calculeaza matricea R folosind algoritmul iterativ.
% Intrari:
% -> nume: numele fisierului din care se citeste;
% -> d: coeficentul d, adica probabilitatea ca un anumit navigator sa
% continue navigarea (0.85 in cele mai multe cazuri)
% -> eps: eroarea care apare in algoritm.
% Iesiri:
% -> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

% Setez numarul de zecimale la 6
digits(6);

% Deschid fisierul
file_graf = fopen(nume, 'r');

% Citesc numarul de noduri (primul rand)
numar_pag = fscanf(file_graf, '%f', 1);

A = zeros(numar_pag); % Matricea de Adiacenta
K = zeros(numar_pag); % Matricea K

for i = 1 : numar_pag

    % Citesc numarul paginii
    nod_crt = fscanf(file_graf, '%f', 1);

    % Citesc numarul de link-uri catre alte pagini
    n = fscanf(file_graf, '%f', 1);
    K(i, i) = n;

    % Citesc link-urile din pagina si le introduc intr-un vector
    V = fscanf(file_graf, '%f', n);
   
    % Caut indexul paginii curente in vectorul de pagini
    ok=0;
    for j = 1 : n
        if V(j) == nod_crt
            index = j;
            ok=1;
        end
    end

    % Elimin pagina curenta din vector
    if(ok==1)
        V(index) = [];
        K(i, i) = n - 1;
    end

    A(nod_crt, V) = 1;
end

% Calculez matricea M
M = (inv(K) * A)';

% Initializez Rt (R(0))
Rt(1 : numar_pag, 1) = vpa(1 / numar_pag);

% Vector coloana 1
unu = ones(numar_pag, 1);

Rt1 = vpa(d * M * Rt + ((unu * (1-d))/ numar_pag));

while(eps <= norm(Rt1 - Rt, 2))
    Rt = Rt1;
    Rt1 = vpa(d * M * Rt + (vpa(unu * (1-d))/ numar_pag));
end

R = Rt1;
fclose(file_graf);
end