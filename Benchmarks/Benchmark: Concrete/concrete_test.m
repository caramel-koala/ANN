%concrete_test.m
%Tests the concrete net created in concrete.m
%AUTHOR: Antonio Peters

clc;
clear;

load concrete.mat

%import and normalise data
D   = csvread('concrete_test.csv');

p = D(:,1:8)';
t = D(:,9)';

%simulate on the new test data
a = sim(connet,p);

%degree of fit
r2 = rsq(t,a);
[R,pv] = corrcoef(t,a);

%plot results
x = 1:size(t,2);
plot(x,t,'bo',x,a,'r*');