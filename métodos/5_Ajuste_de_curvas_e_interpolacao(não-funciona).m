function exercicio3()
  clc;
  x = [2,4,6,7,10,11,14,17,20];
  y = [1,2,5,2,8,7,6,9,12];
  xx = 12.5;


  ordem = input("Defina o grau do seu polinonimo: ");
  [a] = Regressao(x,y,ordem);
  [Aa] = GaussJ(a);


  fprintf("A função é: ");
  for i = 1:length(Aa)-1
    fprintf("%dx^%d + ",Aa(i),i-1);
  endfor

  fprintf("%dx^%d",Aa(length(Aa)),length(Aa));
  fprintf("\n");
  f = estimarX(Aa, xx);

  fprintf("\n");
  fprintf("O valor estimado para x é: %d \n", f);

  Sr = sum(y - f)^2;
  St = sum(y - mean(y))^2;
  r2 = (St-Sr)/St;
  r = sqrt(r2);
  fprintf("Valor de r2 = %f\n valor de r = %f", r2, r);

  geraGrafico(x,y,f,xx,ordem);

endfunction;

function [a] = Regressao(x,y,ordem)
 n = length(x);
 for i = 1:ordem+1
   for j = 1:i
     k = i+j-2;
     soma=0;
     for l = 1:n
       soma = soma+x(l)^k;
     endfor
     a(i,j) = soma;
     a(j,i) = soma;
   endfor
   soma = 0;
   for l = 1:n
     soma = soma + y(l)*x(l)^i-1;
   endfor
   a(i,ordem+2) = soma;
 endfor

endfunction


function [Aa] = GaussJ(a)
  M = zeros(3,4)*1e-6;
  M = a;
  tamanho = size(M,1);
  x = zeros(1,tamanho);

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

  for (i = 1:tamanho )
      M(i,:) = M(i,:)/M(i,i);
      for(j= 1:tamanho)
        if (i != j)
           M(j,:) = M(j,:)-M(j,i)*M(i,:);
        endif
      endfor
    endfor

  for i = tamanho:-1:1
    x(i) = (M(i,end) - sum(M(i,i+1:end-1)))/M(i,i);
  endfor

  for i = 1:tamanho
    Aa(i) = x(i);
  endfor

endfunction


function [z] = estimarX(Aa, xx)
  for i = 1:length(Aa)
    z = Aa(i)*(xx^(i-1));
  endfor


endfunction


function geraGrafico(X,Y,f,xx,ordem)
  clf;
  plot(X,Y,"o", X, polyval(polyfit(X,Y,ordem),X));
  hold on;
  plot(xx,f, 'ro-')
  title(sprintf('Ajuste com polinonimo de %dº ordem',ordem))
  legend('pontos de X,Y', 'regressão', 'ponto estimado de xx')

  xlabel("Valores de X");
  ylabel("Valores de Y");
  set(gca, 'fontsize', 30);

endfunction
