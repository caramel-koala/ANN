y = [5.157 7.284 4.440 30.198 49.648 71.981 104.629 145.679 197.646 250.110 284.899];
x = linspace(0,10,length(y));

b = quadreg(x,y);

xf = linspace(0,10,100);

f = b(1).*xf.^2 + b(2).*xf + b(3);

plot(xf,f,'r',x,y,'o')