%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mpertrain.m
%trains and saves a multi-layer perceptron to solve a classification
%problem
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%Training Pattern
P   = [-0.2 -0.2 -0.3 0.2 0.2 0.3 0.6 0.7 0.8 1.1 1.2 1.3;
       -0.2 -0.3 -0.2 0.2 0.3 0.2 0.6 0.8 0.7 1.2 1.3 1.1];
  
%Training Target
T   = [   1    1    1   0   0   0   0   0   0   1   1   1];

%Splittinng of Target into 2 Targets

T1  = [   1    1    1   0   0   0   0   0   0   0   0   0];
T2  = [   0    0    0   0   0   0   0   0   0   1   1   1];

%Obtain weight matrix for first level of training
W1  = neurtrain(P,T1);
W2  = neurtrain(P,T2);

%Append Weight matrices into one matrix
W   = [W1;W2];

%resize P to remove need for b
P   = [P;ones(1,size(P,2))];

%obtain first layer activation
Ai  = hardlim(W*P);

%Obtain Second layer weight matrix
Wf  = neurtrain(Ai,T);

%resize Ai to remove need for b
Ai  = [Ai;ones(1,size(Ai,2))];

%Obtain final Activation
Af  = hardlim(Wf*Ai);

%Error check
E   = Af - T;

%Store weight matrices (Function stolen from code for Numerical Modelling)
save_to_file([W; Wf], 'weight.dat');

xr  = randu(-1.5,2,1,100);
yr  = randu(-1.5,2,1,100);
r   = [xr;yr];
a   = mpersim(r);

%PLOTTING LINES
%--------------------------------------------------------------------------
hold on
x = linspace(-2,2,100);

y1  = -(W(1,1)*x + W(1,3))/W(1,2);
y2  = -(W(2,1)*x + W(2,3))/W(2,2);

plot(x,y1,'b',x,y2,'r');
%--------------------------------------------------------------------------

%PLOT PONITS
%--------------------------------------------------------------------------
for i=1:length(a)
	if a(i) == 1
		plot(r(1,i),r(2,i),'o');
	else
		plot(r(1,i),r(2,i),'.');
	end
end
hold off
%--------------------------------------------------------------------------