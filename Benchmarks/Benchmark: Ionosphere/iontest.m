%iontest.m
%tests the net ionnet created in ionosphere.m
%Author: Antonio Peters

clc;
clear;

load ionosphere.mat

%import and normalise test data (similar to mushrooms.m)
D   = fopen('iontest.dat');

D = textscan(D,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %c');

p = [D{1} D{2} D{1} D{3} D{4} D{5} D{6} D{7} D{8} D{9} D{10} D{11} D{12} D{13} D{14} D{15} D{16} D{17} D{18} D{19} D{20} D{21} D{22} D{23} D{24} D{25} D{26} D{27} D{28} D{29} D{30} D{31} D{32} D{33} D{34}]';

T = [D{35}]';

t = [];

for i = 1:size(T,2)
    if T(i) == 'g'
        t(i) = 1;
    else
        t(i) = 0;
    end
end

%simulate on the new test data
a = sim(ionnet,p);

%convert back to numbers
a = round(a);

%degree of fit
r2 = rsq(t,a);
[R,pv] = corrcoef(t,a);

%plot results
x = 1:size(t,2);
plot(x,t,'bo',x,a,'r*');