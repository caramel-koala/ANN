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

%Append Weight matrices into one matrix
W   = [W1;W2];

%resize P to remove need for b
P   = [P;ones(1,size(P,2))];

%obtain first layer activation
Ai  = hardlim(W*P);

%Obtain Second layer weight matrix
Wf  = neurtrain(Ai,Tf);

%resize Ai to remove need for b
Ai  = [Ai;ones(1,size(Ai,2))];

%Obtain final Activation
Af  = hardlim(Wf*Ai);

%Error check
E   = Af - Tf;

%PLOTTING
%--------------------------------------------------------------------------
x = linspace(-1,2,100);

y1  = -(W1(1)*x + W1(3))/W1(2);
y2  = -(W2(1)*x + W2(3))/W2(2);

plot(P(1,:),P(2,:),'o',x,y1,'b',x,y2,'r');
%--------------------------------------------------------------------------