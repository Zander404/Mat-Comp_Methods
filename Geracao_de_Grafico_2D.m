function graficoAnimado(xl, xu, XR, FXR, imax)
  ## c�digo tempor�rio para calcular a fun��o no intervalo especificado
  intervalo = xl:0.1:xu;
  temp = zeros(size(intervalo));
  for cont = 1:numel(intervalo)
    temp(cont) = funcao(intervalo(cont));
  end
  for iter = 1:imax
    figure(1);
    plot(intervalo, temp, 'linewidth', 3, 'linestyle', '-', 'color', 'black');
    hold on;
    plot(XR(iter), FXR(iter), 'marker', 'o', 'markersize', 20, 'linewidth', 3, 'color', 'blue', 'markerfacecolor', 'blue');
    hold off;
    set(gca, 'fontsize', 20);
    grid on;
    title(sprintf('Iteracao: %i; f(%.6f) = %.6f', iter, XR(iter), FXR(iter)));
    pause(0.1);
  end
endfunction

function graficosConvergencia(iter, FXR, XR)
##  figure(2);
##  plot(1:iter, [FXR XR], 'linewidth', 2);
##  set(gca, 'fontsize', 20);
##  ylabel('f(x)');
##  xlabel('Iteracao');
##  grid on;
##  xlim([1 iter]);
##  ylim([min(FXR) - 1, max(FXR) + 1]); 
##  title('Grafico de convergencia');
##  legend('f(x)', 'x', 'location', 'northwest');

  figure(2);
  subplot(2, 1, 1);
  plot(1:iter, [XR], 'linewidth', 2);
  set(gca, 'fontsize', 20);
  ylabel('x');
  xlabel('Iteracao');
  grid on;
  xlim([1 iter]);
  ylim([min(XR) - 1, max(XR) + 1]); 
  title('Grafico de convergencia de x');
  
  subplot(2, 1, 2);
  plot(1:iter, [FXR], 'linewidth', 2);
  set(gca, 'fontsize', 20);
  ylabel('f(x)');
  xlabel('Iteracao');
  grid on;
  xlim([1 iter]);
  ylim([min(FXR) - 1, max(FXR) + 1]); 
  title('Grafico de convergencia de f(x)');

end
