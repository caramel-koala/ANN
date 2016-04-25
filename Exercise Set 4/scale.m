%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scale.m
%Main launcher for all backpropdemo questions
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [u, a, b] = scale(i)

%get max and min
iM = max(i')';
im = min(i')';

%get a and b
a = 2./(iM-im);
b = (iM+im)./(iM-im);

%scale i
Di = diag(a);

u = Di*i + repmat(b,1,size(i,2));

end