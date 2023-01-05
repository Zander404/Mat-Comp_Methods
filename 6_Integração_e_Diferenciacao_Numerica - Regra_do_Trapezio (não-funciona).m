function exercicio31()
  clc

##info do exercicio
  imax = 1000;
  tolMax = 1e-6;
  n = 7;
  a = 0;
  b = 1;



## Declaracao das Funcoes
  f = @(x)((x.^7)-(2.*(x.^2))-1);
  f1 = @(x) (7*(x.^6)) - (4*x);
  f2 = @(x) (42*(x.^5)) - 4;

  [I,~] = trap_comp(a,b, n);
  [I2] = trap_comp2(a,b, n);


#### Verificação para ver se o calculo da Integral esta correto

  for i= 1:imax
    ea = abs(-(b-a)^3/(12*((n+i)^2))*(I2/b-a));

    if ea <= tolMax
      fprintf("O valor da Integral é aproximadamente: %d \n", I+ea);
      fprintf("Com o uso total de (%d) segmentos \n", i);
      break
    endif

  endfor

 x = linspace(0,1,n);
 y = func(x);
  geraGrafico(x,y)

endfunction


function [y] = func(x)

  y = ((x.^7)-(2.*(x.^2))-1);

endfunction


function [I,y] = trap_comp(a,b,n)

  h = (b-a)/n;
  x = a:h:b;
  y = func(x);
  I = y(1);

  for i = 2:n
    I = I + 2*y(i);
  endfor

  I = (h/2)*(I+y(n));

endfunction

function [I2] = trap_comp2(a,b,n)

  h = (b-a)/n;
  x = a:h:b;
  f2 = @(x) (42*(x.^5)) - 4;
  y = f2(x);
  I2 = y(1);

  for i = 2:n
    I2 = I2 + 2*y(i);
  endfor

  I2 = (h/2)*(I2+y(n));


endfunction




function geraGrafico(X,Y)
  clf;

  figure(1);
  subplot(2,1,1);
  plot(1:numel(X),X, 'linewidth',2);
  set(gca,'fontsize',20);
  title("Convergência de X")
  xlabel('Elemento');
  ylabel('Valor de X');

  subplot(2,1,2);
  plot(1:numel(Y),Y, 'linewidth',2);
  set(gca,'fontsize',20);
  title("Aproximação de F(x)da Integral")

  xlabel("Elemento");
  ylabel('F(x)');



endfunction
