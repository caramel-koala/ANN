%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ANN Exercise Set 3
% Exercise 3.8.3.[3]
%Gradient Descent Regression Sine Approximation
%Author: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; 
close all;

t 		= 0:10;
t2		= 0:0.1:10;
y 		= [0	2.67	-2.32	-0.80	2.98	-1.55	-1.61	2.83	-0.86	-2.35	2.87];
hold on;
plot(t,y,'o');

x 		= [3.3 	2.2]';

f		=@(x,t) x(1).*sin(x(2).*t);
gradE	=@(x,t) [2*(x(1).*sin(x(2).*t) - y).*sin(x(2).*t); 2*(x(1).*sin(x(2).*t) - y).*t.*x(1).*cos(x(2).*t)];

E 		= sum((f(x,t)-y).^2);
a		= 0.01;
count	= 2;

while(E > sqrt(a) )%&& count < 10000)
	x		= x - (a/sqrt(count))*(sum(gradE(x,t),2)./length(t));
	E 		= sum((f(x,t)-y).^2)
	count = count +1;
end

plot(t2,f(x,t2));

hold off;