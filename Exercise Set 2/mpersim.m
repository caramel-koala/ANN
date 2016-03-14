%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mpersim.m
%loads a saved weigh matrix and classifies points accordingly
%problem
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Af = mpersim(P)

%Extend P to remove need for b
P   = [P; ones(1,length(P))];

%Load data file
data    = load('weight.dat');

W   = [data(:,1),data(:,2)]';
Wf  = data(:,3)';

%First activation
Ai  = hardlim(W*P);

%resize Ai to remove need for b
Ai  = [Ai;ones(1,size(Ai,2))];

%Obtain final Activation
Af  = hardlim(Wf*Ai);

end