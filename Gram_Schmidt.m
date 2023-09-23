function [Q, R] = Gram_Schmidt(A)
% Algoritm preluat de la laborator
  [m, n] = size(A);
  Q = zeros(m, n);
  R = zeros(n);
  
  for j = 1:n
    for i = 1:j-1
      R(i, j) = Q(:, i)' * A(:, j);
    end
    
    s = zeros(m, 1);
    for i = 1:j-1
      s = s + R(i, j) * Q(:, i);
    end
    
    aux = A(:, j) - s;
    
    R(j, j) = norm(aux, 2);
    Q(:, j) = aux / R(j, j);
  end
end
