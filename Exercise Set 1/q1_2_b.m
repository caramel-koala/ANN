y =[0 1.8127 3.2968 4.5119 5.5067 6.3212 6.9881 7.5340 7.9810 8.3470 8.6466];
x = linspace(0,10,length(y));

f =@(b,x) b(1)*(1-exp(-b(2)*x));

beta0 = [1;1];

beta = nlinfit(x,y,f,beta0)

xf = linspace(0,10,100);

plot(x,y,'o',xf,f(beta,xf),'b');

