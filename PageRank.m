function [R1, R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out

% Deschid fisierul
fgraf = fopen(nume, 'r'); 
numar_pag = fscanf(fgraf, '%f', 1); 

nume_out = strcat(nume, '.out'); 

% Fac un fisier de iesire care poate fi modificat
fgraf_out = fopen(nume_out, 'w'); 
fprintf(fgraf_out, '%d \n', numar_pag);
 
%Calculez vectorul PageRank cu algoritmul Iterative
R1 = Iterative(nume, d, eps);
fprintf(fgraf_out, '%f \n', R1); 
fprintf(fgraf_out, '\n'); 

%Calculez vectorul PageRank cu algoritmul Algebraic
R2 = Algebraic(nume, d);
fprintf(fgraf_out, '%f \n', R2); 
fprintf(fgraf_out, '\n'); 

%Skip pana la val1 si val2 (ultimele 2 linii din fisierul de input)
for i = 1:numar_pag+1
  fgets(fgraf);
end

val1 = fscanf(fgraf, '%f', 1);
val2 = fscanf(fgraf, '%f', 1); 

n = numar_pag; 
index = (1:n);
index;

%Sortez indicii
for i = 1:n-1
  for j = i+1:n

    if(R2(index(i)) <= R2(index(j)))
        aux = index(i); 
        index(i) = index(j);
        index(j) = aux;
    end

  end 
end
   
%Afisez
for i = 1:n

  fprintf(fgraf_out, '%d ', i);
  fprintf(fgraf_out, '%d ', index(i));

  y = Apartenenta(R2(index(i)), val1, val2);

  fprintf(fgraf_out, '%f \n', y);

end
  
fclose(fgraf);
fclose(fgraf_out);
end

