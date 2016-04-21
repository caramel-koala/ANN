%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%backpropdemo1a.m
%Based on Example 4.3.4 with 1 layer
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
close all
%generate inputs and targets
p=[0:pi/4:2*pi]';
t=3*sin(2*p)+1;
[r,q]=size(p);
[s,q1]=size(t);
%check that the number of samples are the same
if (q~=q1)
error('different sample sizes');
end

% the number of neurons in each layer
s1=s;
%transfer functions
f1=@tansig;
%learning rate
h=.1;

%initiate weights and biases
W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);

%tolerance
tol=.001;
%counter
k=1;
maxit=100;
E(1)=1;

while abs(E)>tol & k<maxit
    k=k+1;
    %propagate through the net
    n1=W1*p+b1;
    a1=f1(n1);
    %compute error
    e=t-a1;
    sse=sum(e.^2);
    E(k)=sse;
    %derivative matrices
    D1=diag(1-a1.^2);
    %sensitivities
    S1= -2*D1*e;
    %update
    W1=W1-h*S1*p';
    b1=b1-h*S1;
end
%remove the first error: E(1)
E=E([2:end]);

figure
plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n',tol));
rsq= r2(a1,t);
%compare with function
x=linspace(0,2*pi,101);
y=3*sin(2*x)+1;
figure
plot(p,t,'o')
hold on
plot(p,a1,'*')
plot(x,y)
hold off
title(sprintf('activation vs targets r2 stat = %g\n',rsq))