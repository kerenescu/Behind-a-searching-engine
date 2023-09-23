function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Se va inlocui aceasta linie cu descrierea algoritmului de inversare

[Q, R] = Gram_Schmidt(A);

Q = Q';
[n, ~] = size(R);
B = zeros(n, n);

for i=1:n
    %Rezolva SST
    B(1:n, i) = SST(R, Q(1:n,i));
end

end