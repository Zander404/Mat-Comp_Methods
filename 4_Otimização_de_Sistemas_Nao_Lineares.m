function exercicio10l()
  clc
  imax = 100;
  x0=[-1 -1]';
  x1 = zeros(2,imax)';
  tolerancia = 1e-5;


  func = @(x,y) 0.5 + ((1/2)*((x^4) - 16*(x^2) + 5*x + (y^4) - 16*(y^2) + 5*y));
  g = @(x0) [((4 * (x0(1) ^ 3) - 32 * x0(1) + 5) / 2); ((4 * (x0(2) ^ 3) - 32 * x0(2) + 5) / 2)];
  h = @(x0) [((12 * (x0(1) ^ 2) - 32) / 2), 0; 0, ((12 * (x0(2) ^ 2) - 32) / 2)];




  flag = menu("Defina o método", "Gradiente", "Newton", "BFGS"); ## Condição de seleção de métodos      1.Gradiente        2. Newton      3. BFGS


  xold = inf(2,1);
  D = eye(2); ##D é uma matriz indentidade


  for iter = 1:imax
      if flag == 1
        x1 = x0 - 0.04*g(x0);

      elseif flag == 2
        x1 = x0 - 1.5*(h(x0)\g(x0));

      elseif flag == 3

        af = 0.025236;
        s = (-af)*D*g(x0);
        y = g(x0+s)-g(x0);
        D = D - ((s'*y + y'*D*y)*(s*s'))/(s'*y)-(D*y*s'+s*y'*D)/(s'*y);
        x1 = x0 - (af)*D*g(x0);
##

      endif

    fxr(:,iter) = x1;

    es = abs(xold - fxr(:,iter));
    xold = x0;
    x0 = x1;

    fprintf("Valor na posicao %d ",iter);
    fprintf(" x = %d, y = %d ",x0(1), x0(2));
    fprintf("\n");
    todosX(iter, :) = x0;
    todosY(iter,:) = func(x0(1),x0(2));


    if es <= tolerancia
      break;
    endif

  endfor

  plotarGrafico(todosX, todosY, iter);

endfunction


function plotarGrafico(todosX, todosY,iter)
  clf;
  x = -5:0.1:5;
  y = x;
  F = zeros(length(x), length(y));
  func = @(x,y) 0.5 + ((1/2)*((x^4)-16*(x^2)+5*x+(y^4)-16*(y^2)+5*y));

  for xx = 1:numel(x)
    for yy = 1:numel(y)
      F(xx, yy, 1:2) = func(x(xx), y(yy));
    endfor
  endfor

    for cont = 1:iter
    figure(1);
    subplot(211)
    p1 = surf(x, y, F(:, :, 1));
    hold on
    p2 = plot3(todosX(1:cont, 2), todosX(1:cont, 1), todosY(1:cont, 1), 'color', 'r', 'linewidth', 2);
    p3 = plot3(todosX(cont, 2), todosX(cont, 1), todosY(cont, 1), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2);
    hold off
    legend("F(X,Y)","Trajetoria", "Posição estimada do extremo mínimo", 'location', 'northwestoutside');
    set(gca, 'fontsize', 15);
    grid on;
    title(sprintf('Iter %i', cont));
    subplot(212)
    surf(x, y, F(:, :, 2));
    hold on;
    plot3(todosX(1:cont, 2), todosX(1:cont, 1), 'color', 'r', 'linewidth', 2);
    plot3(todosX(cont, 2), todosX(cont, 1), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', [1 1 1], 'linewidth', 2);
     view([135 45]);
    hold off;
    set(gca, 'fontsize', 30);
    grid on;
    pause(0.1);

endfor


  figure(2);
  subplot(311)
  plot(1:iter, todosX, 'linewidth', 2);
  title(sprintf('TODOS OS VALORES DE X'));
  set(gca, 'fontsize', 30);
  xlabel("ITERAÇÕES");
  ylabel(" VALORES DE X e Y");
  legend('x','y');
  grid on;

  fxx = zeros(2,iter);
  for i = 1:iter
    fxx(:,i) = func(todosX(i),todosY(i));
  endfor


  subplot(312);
  plot(1:iter,todosY, 'linewidth', 2);
  set(gca, 'fontsize', 30);
  title(sprintf('VALORES DE F(X,Y)'));
  grid on;
  xlabel("ITERAÇÕES");
  ylabel("VALORES DE F(X,Y)");
  legend('f1');

endfunction
