%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%xorprob.m
% Solves the XOR problem using a perceptron
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%XOR Pattern
P   = [ 1   1   0   0;
        1   0   1   0];

%Removing need for bias operation
P   = [ P;  ones(1,length(P))];

%XOR Target
T   = [ 0   1   1   0];

%XOR First Weighting
W1  = [-1  -1   0.5;
        1   1  -1.5];

%First OR and NOR Operation using the weighting
A1  = hardlim(W1*P);

%XOR second weighting
W2  = [-1 -1];

%Second OR operation for final XOR
A2  = hardlim(W2*A1);

%Error vector check
E   = T - A2;

%PLOTTING
%--------------------------------------------------------------------------
x = linspace(-1,2,100);

y1  = -(W1(1,1)*x + W1(1,3))/W1(1,2);
y2  = -(W1(2,1)*x + W1(2,3))/W1(2,2);

plot(P(1,:),P(2,:),'o',x,y1,'b',x,y2,'r');
%--------------------------------------------------------------------------