%iontest.m
%tests the net ionnet created in ionosphere.m
%Author: Antonio Peters

clc;
clear;

load energy.mat

%import and normalise data
D = csvread('energytest.csv');

p = D(:,1:8)';
t = D(:,9:10)';

%simulate on the new test data
a = sim(energynet,p);

%degree of fit
r2 = rsq(t,a);
[R,pv] = corrcoef(t,a);

%plot results
x = 1:size(t,2);
plot(x,t(1,:),'bo',x,a(1,:),'r*');
figure;
plot(x,t(2,:),'bo',x,a(2,:),'r*');