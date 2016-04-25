%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%backpropdemo1b.m
%Based on Example 4.3.4 with 1 layer
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [E,a] = backpropdemo1b(p,t,tol)

%check that the number of samples are the same
[r,q]=size(p);
[s,q1]=size(t);
if (q~=q1)
error('different sample sizes');
end

%transfer functions
f1=@purelin;
%learning rate
h=.1;

%initiate weights and biases
W1=randu(-1,1,s,r);
b1=randu(-1,1,s,1);

%counter
k=1;
maxit=100;
E(1)=1;

while abs(E)>tol & k<maxit
    k=k+1;
    %propagate through the net
    n1=W1*p+b1;
    a=f1(n1);
    %compute error
    e=t-a;
    sse=sum(e.^2);
    E(k)=sse;
    %derivative matrices
    D1=eye(s);
    %sensitivities
    S1= -2*D1*e;
    %update
    W1=W1-h*S1*p';
    b1=b1-h*S1;
end
%remove the first error: E(1)
E=E([2:end]);

end