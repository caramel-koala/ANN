%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mper2.m
%creates trains and save a specific classification problem
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%Pattern
P   = [-.2  -.2 -.3 .2  .2  .3  .6  .7  .8  1.1 1.2 1.3;
       -.2  -.3 -.2 .2  .3  .2  .6  .8  .7  1.2 1.3 1.1];
   
%Target
T   = [ 0   0   0   0   0   0   1   1   1   1   1   1;
        0   0   0   1   1   1   0   0   0   1   1   1];
    
%Create first layer targets
T1  = [ 0   0   0   0   0   0   1   1   1   1   1   1;
        0   0   0   1   1   1   1   1   1   1   1   1];
T2  = [ 0   0   0   0   0   0   1   1   1   1   1   1;
        1   1   1   1   1   1   0   0   0   0   0   0];
T3  = [ 0   0   0   0   0   0   1   1   1   1   1   1;
        0   0   0   0   0   0   0   0   0   1   1   1];
    
%Obtain weight matrix for first level of training
W1  = neurtrain(P,T1);
W2  = neurtrain(P,T2);
W3  = neurtrain(P,T3);

%Append Weight matrices into one matrix
Wi  = [W1;W2;W3];

 %resize P to remove need for b
P   = [P;ones(1,size(P,2))];

%obtain first layer activation
Ai  = hardlim(Wi*P);

%Obtain Second layer weight matrix
Wf  = neurtrain(Ai,T);

%resize Ai to remove need for b
Ai  = [Ai;ones(1,size(Ai,2))];

%Obtain final Activation
Af  = hardlim(Wf*Ai);

%Error check
E   = Af - T;

%Store weight matrices (Function stolen from code for Numerical Modelling)
%save_to_file(Wi, 'Wi.dat');
%save_to_file(Wf, 'Wf.dat');

%PLOT PONITS
%--------------------------------------------------------------------------
hold on
for i=1:length(P)
	if Af(1,i) == 1 && Af(2,i) == 1
		plot(P(1,i),P(2,i),'o');
    elseif Af(1,i) == 1 && Af(2,i) == 0
		plot(P(1,i),P(2,i),'*');
    elseif Af(1,i) == 0 && Af(2,i) == 1
		plot(P(1,i),P(2,i),'x');
    else
		plot(P(1,i),P(2,i),'.');
	end
end
hold off
%--------------------------------------------------------------------------