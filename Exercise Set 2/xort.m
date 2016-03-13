%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%xort.m
% Uses neutrain to solve the XOR problem
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%XOR Pattern
P   = [ 1   1   0   0;
        1   0   1   0];

%Target Patterns
T1  = [ 1   1   1   0];
T2  = [ 0   1   1   1];
Tf  = [ 0   1   1   0];

%Get weightings
W1  = neurtrain(P,T1);
W2  = neurtrain(P,T2);

W   = [W1;W2];

P   = [P;ones(1,size(P,2))];

Ai  = hardlim(W*P);

Wf  = neurtrain(Ai,Tf);

Ai  = [Ai;ones(1,size(Ai,2))];

Af  = hardlim(Wf*Ai);

%PLOTTING
%--------------------------------------------------------------------------
x = linspace(-1,2,100);

y1  = -(W1(1)*x + W1(3))/W1(2);
y2  = -(W2(1)*x + W2(3))/W2(2);

plot(P(1,:),P(2,:),'o',x,y1,'b',x,y2,'r');
%--------------------------------------------------------------------------