function exercicio10
  format long;
  clc;

  M = zeros(3,4)*1e-6;
  M = [ 3,2,0,13;3,2,1,13;2,1,3,9];
##  M = [0.3,-0.2,10,71.4;3,-0.1,-0.2,7.85;0.1,7,-0.3,-19.3];

  contNormalizador = 0;
  contAnulador = 0;
  cont = 0;
  x = zeros(1,3);

  tamanho = size(M,1);


  fprintf("\nMatriz inicial do problema\n");
  M


   for j = 1:tamanho
   if j==1
     aux = M(1,:);
     M(1,:) = M(j+1,:);
   elseif(j==tamanho)
    M(j,:) = aux;
   else
    M(j,:) = M(j+1,:);
   endif
 endfor



##  for (col = 1:tamanho)
##    [~,pos] = max(abs(M(col:end,col)))
##    if (col -1 +pos != col)
##       aux = M(col -1 +pos,:);
##       M(col -1 +pos,:) = M(col,:);
##       M(col,:) = aux;
##    end
##  end

  fprintf("Matriz com pivotamento parcial\n");
  M


  for (i = 1:tamanho )
      M(i,:) = M(i,:)/M(i,i);
      for(j= 1:tamanho)
        if (i != j)
           M(j,:) = M(j,:)-M(j,i)*M(i,:);
        end
      end
    end

  for i = tamanho:-1:1

    x(i) = (M(i,end) - sum(M(i,i+1:end-1)))/M(i,i);

  endfor


  fprintf("\nResultado na Matriz \n\n");
  M

  for  i = i:tamanho
    fprintf("\nValor de X%d = %d \n ", i, x(i));

  endfor

endfunction



