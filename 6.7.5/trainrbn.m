%trainrbnxor.m
%Solves the XOR problem using RBN net
%Author: Antonio Peters

clc;
clear;

[x,y]   = meshgrid(0:.25:1);

x=x(:)';
y=y(:)';

p=[x;y];

t=tansig(x.^2+y.^3+sin(x.*y));

m = input('Number of centres = ');

d   = max(max(dist(p',p)));
s   = d*sqrt(log(2))/sqrt(m);

net = newrb(p,t,0.001,s,m);

[X,Y]   = meshgrid(-0.5:.01:1.5);

X=X(:)';
Y=Y(:)';

P=[X;Y];

A = sim(net,P);
A = reshape(A,[201,201]);

[X,Y]   = meshgrid(-0.5:.01:1.5);

hold on
surf(X,Y,A);
plot3(x,y,t,'r*');
hold off