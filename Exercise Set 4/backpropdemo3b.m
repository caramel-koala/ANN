%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%backpropdemo3b.m
%Based on Example 4.3.4 bu with a varying number of hidden layer nodes
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
s1=4;
s2=3;
s3=s;
%transfer functions
f1=@tansig;
f2=@tansig;
f3=@purelin;
%learning rate
h=.1;

%initiate weights and biases
W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);
W2=randu(-1,1,s2,s1);
b2=randu(-1,1,s2,1);
W3=randu(-1,1,s3,s2);
b3=randu(-1,1,s3,1);

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
    n2=W2*a1+b2;
    a2=f2(n2);
    n3=W3*a2+b3;
    a3=f3(n3);
    %compute error
    e=t-a3;
    sse=sum(e.^2);
    E(k)=sse;
    %derivative matrices
    D3=eye(s3);
    D2=diag(1-a2.^2);
    D1=diag(1-a1.^2);
    %sensitivities
    S3= -2*D3*e;
    S2= D2*W3'*S3;
    S1= D1*W2'*S2;
    %update
    W3=W3-h*S3*a2';
    b3=b3-h*S3;
    W2=W2-h*S2*a1';
    b2=b2-h*S2;
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
rsq= r2(a3,t);
%compare with function
x=linspace(0,2*pi,101);
y=3*sin(2*x)+1;
figure
plot(p,t,'o')
hold on
plot(p,a3,'*')
plot(x,y)
hold off
title(sprintf('activation vs targets r2 stat = %g\n',rsq))