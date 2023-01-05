function exercicio8()
  itermax = 1000;
  tolerancia= 1e-5;
  xl = 0;
  xu = 5;
  [xr, iter, xrs] = metodoFalsaPosicao(xl,xu,itermax,tolerancia);
  fxr = zeros(1,iter);

  for i = 1:iter
   fxr(i) = func(xrs(i));
  endfor
  fxr

  fprintf('Total de Iteracaoes: %d \n ', iter);

  graficoAnimado(xl, xu, xrs,fxr,iter);

  graficosConvergencia(iter,fxr, xrs);

endfunction;
function y = func(x)

  y = 16*x*sin(x/10)-(37/2);

endfunction

function [xr, iter, xrs] = metodoFalsaPosicao(xl,xu,itermax,tolerancia)
  xrold = inf;
  xrs = zeros(1,itermax);
  for iter = 1:itermax;
    xr = xu-(func(xu)*(xl-xu))/(func(xl)-func(xu));
    xrs(iter) = xr;
    fprintf("Iteracao n%d: %f\n",iter,xr);
    es = abs(xrold - xr);
    xrold = xr;
    if es < tolerancia
      break
    endif

    if (func(xu)*func(xl) > 0)
      xu = xr;
    endif

    if (func(xu)*func(xl) < 0)
      xl = xr;
    endif

  endfor

  xrs = xrs(1:iter);
endfunction



function graficoAnimado(xl, xu, XR, FXR, imax)

  intervalo = xl:0.1:xu;
  temp = zeros(size(intervalo));
  for cont = 1:numel(intervalo)
      temp(cont) = func(intervalo(cont));
  end
  for iter = 1:imax
    figure(1);
    plot(intervalo, temp, 'linewidth', 3, 'linestyle', '-', 'color', 'black');
    hold on;
    plot(XR(iter), FXR(iter), 'marker', 'o', 'markersize', 5, 'linewidth', 3, 'color', 'blue', 'markerfacecolor', 'blue');
    hold off;
    set(gca, 'fontsize', 20);
    grid on;
    title(sprintf('Iteracao: %i; f(%.6f) = %.6f', iter, XR(iter), FXR(iter)));
    pause(0.1);
  end
endfunction

function graficosConvergencia(iter, FXR, XR)


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

