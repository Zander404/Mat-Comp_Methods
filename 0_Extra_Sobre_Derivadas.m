##x = [1 2 3 4 5 6]
##y = [2 4 6 8 10 12]
##
##derivX = diff(x)  ## Diferenca dos valores do vetor de x
##derivY = diff(y)  ## diferenca di valores do vetor de y

##deriv = derivY/derivX ## Derivada dos valores


##Derivada de uma parabola
f= @(x) 4*x^2+3;
x = [1 2 3 4 5 6]
y = [7 19 39 67 103 147]

derivX = diff(x)
derivY = diff(y)

deriv = derivY/derivX

##Plotagem de grafico

plot(x,[0 diff(y)], 'linewidth',2)


## Teste

  x = [2,4,6,7,10,11,14,17,20];
  y = [1,2,5,2,8,7,6,9,12];




##Itegral

int = cumsum(deriv)







