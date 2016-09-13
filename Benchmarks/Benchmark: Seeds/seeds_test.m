%seeds-test.m
%tests the net seednet created in seeds.m
%Author: Antonio Peters

clc;
clear;

load seed.mat

%import and normalise data
D = fopen('seeds_test.dat');

D = textscan(D,'%f %f %f %f %f %f %f %f');

p = [D{1} D{2} D{1} D{3} D{4} D{5} D{6} D{7}]';
T = D{8}';

t = zeros(3,length(T));

for i = 1:length(T)
    if T(i) == 1
        t(:,i) = [1 0 0]';
    elseif T(i) == 2
        t(:,i) = [0 1 0]';
    else
        t(:,i) = [0 0 1]';
    end
end

a=sim(seednet,p); %all

a = round(a);

ap = [];

for i = 1:size(t,2)
    if a(:,i) == [1 0 0]'
        ap(i) = 1;
    elseif a(:,i) == [0 1 0]'
        ap(i) = 2;
    elseif a(:,i) == [0 0 1]'
        ap(i) = 3;
    else ap(i) = 0;
    end
end

%plot results
x = 1:length(T);
plot(x,T,'bo',x,ap,'r*');