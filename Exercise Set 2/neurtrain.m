%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neurtrain.m
% Uses a single neuron to solve a problem given the pattern and target
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [W] = neurtrain(P,T)

%get matrix sizes
[p1,p2] = size(P);
[t1,t2] = size(T);

if p2 ~= t2
    fprintf('Invalid data');
    return;
end

%Extend P to remove need for b
P = [P; ones(1,p2)];

%generate initial weighting
W   = rand(t1,p1+1);

%generate initial bias
b   = rand(p2,1);

%first activation
A   = W*P;

%error vector
E   = T - A;

%max itteration for
halt    = 0;
max = 1000;

while sum(E.^2) > 0 && halt < max
    %update
	W = W + E * P';
	
	A = hardlim(W*P);

	E = T - A;

	halt = halt + 1;
end

if halt == max
    fprintf('Could not be solved in %d itterations',max);
    return
end

end