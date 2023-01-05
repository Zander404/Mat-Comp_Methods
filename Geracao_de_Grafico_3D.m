function geraGraficoFuncao(limInfInt, limSupInt, todosX, todosY, iter)
  x = limInfInt:0.1:limSupInt;
  y = x;
  F = zeros(length(x), length(y), 2);
  for xx = 1:numel(x)
    for yy = 1:numel(y)
      F(xx, yy, 1:2) = sistema([x(xx); y(yy)]);
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
    keyboard
  endfor

    figure(2);
    subplot(211)
    plot(1:iter, todosX, 'linewidth', 2)
    set(gca, 'fontsize', 30);
    grid on;

    subplot(212)
    plot(1:iter, todosY, 'linewidth', 2)
    set(gca, 'fontsize', 30);
    grid on;

endfunction
