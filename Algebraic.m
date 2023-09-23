function PR = Algebraic (nume, d) 
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

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
 
%Calculez matricea M cu ajutorul algoritmului Gram-Schmidt
M = (PR_Inv(K) * A)';

I = eye(numar_pag);
unu = ones(numar_pag,1);

%Calculez R(t) folosind inversa
Rt = vpa(PR_Inv(I - d * M));
PR = ((1 - d) * Rt * unu/numar_pag);

fclose(file_graf);
end