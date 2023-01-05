function exercicio6()
  tolerancia = 1e-5;
  inter_max = 1000;
  x=0;
  x0 = [1.5;3.5];
  x1 = zeros(2,1);
  x;
  iter = 0;
  xrs = 0;
  [iter,fxr,es, todosX, todosY] = Newton(x0,inter_max, tolerancia);

  limSupInt = max(fxr(1,:));
  limInfInt = min(fxr(2,:));

  geraGraficoFuncao(limInfInt, limSupInt, todosX,todosY, iter)

endfunction


function y = func(x, y)
  y = [x*cos(x)+y; e^((-2*x)+y)];

endfunction


function zd = dx(x,y)

##  zd(1,1)=-x*sin(x)+cos(x);
##  zd(1,2)= 1;
##  zd(2,1)= e^(-2*x+y)*(-2);
##  zd(2,2)= e^(-2*x+y);

  zd = [-x*sin(x)+cos(x),1;e^(-2*x+y)*(-2),e^(-2*x+y)];

endfunction





function [iter, fxr, es, todosX, todosY ] = Newton(x0,imax,tolerancia)
  x1old = inf;
  x=0;
  xrs=0;
  fxr= zeros(2,imax);
  fxr(1,1) = inf;
  for iter = 1:35;
    x1 = x0 - inv(dx(x0(1),x0(2))) * func(x0(1),x0(2));
##    x1 = x0 -(func(x0(1),x0(2))/dx(x0(1),x0(2)));
    fxr(:,iter) = x1;

    if iter==1
     es = max(abs(fxr(1,iter)));

    else
      es = abs(fxr(:,iter) - fxr(:,iter-1));

    endif
    x0 = x1;
    fprintf("Valor na posicao %d ",iter);

    fprintf(" x = %d, y = %d ",x0(1), x0(2) );
    fprintf("\n");
    todosX(iter, :) = x1;
    todosY(iter,:) = func(x0(1),x0(2));

    if es <= tolerancia
      break;
    endif


endfor
fprintf("\n Total de Interacoes: %d\n", iter);
endfunction



function geraGraficoFuncao(limInfInt, limSupInt, todosX, todosY, iter)
  x = limInfInt:1:limSupInt;
  y = x;
  F = zeros(length(x), length(y), 2);
  for xx = 1:numel(x)
    for yy = 1:numel(y)
      F(xx, yy, 1:2) = func(x(xx), y(yy));
    end
  end
  for cont = 1:iter
    figure(1);
    subplot(211)
    surf(x, y, F(:, :, 1));
    hold on
    plot3(todosX(1:cont, 2), todosX(1:cont, 1), todosY(1:cont, 1), 'color', 'r', 'linewidth', 2)
    plot3(todosX(cont, 2), todosX(cont, 1), todosY(cont, 1), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off
    set(gca, 'fontsize', 30);
    grid on;
    title(sprintf('Iter %i', cont));
    subplot(212)
    surf(x, y, F(:, :, 2));
    hold on;
    plot3(todosX(1:cont, 2), todosX(1:cont, 1), todosY(1:cont, 2), 'color', 'r', 'linewidth', 2)
    plot3(todosX(cont, 2), todosX(cont, 1), todosY(cont, 2), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2)
    hold off;
    set(gca, 'fontsize', 30);
    grid on;
    pause(0.1);

endfor


    figure(2);
    subplot(311)
    plot(1:iter, todosX, 'linewidth', 2)
    title(sprintf('Todos os valores de X'));
    set(gca, 'fontsize', 30);
    xlabel("iterações");
    ylabel(" valores de X");
    legend('f1','f2');
    grid on;

    fxx = zeros(2,iter);
    for i = 1:iter
      fxx(:,i) = func(todosX(i),todosY(i));
    endfor


    subplot(312);
    plot(1:iter,todosY, 'linewidth', 2);
    set(gca, 'fontsize', 30);
    title(sprintf('Todos os valores de Y'));
    grid on;
    xlabel("iterações");
    ylabel("valores de Y");
    legend('f1','f2');

    subplot(313);
    plot(1:iter, fxx, 'linewidth', 2);
    set(gca, 'fontsize', 30);
    title(sprintf('Gráfico da Convergência: '));
    xlabel('iterações');
    ylabel("f(x)");
    grid on;


endfunction

