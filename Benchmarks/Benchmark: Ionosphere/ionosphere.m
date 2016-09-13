%ionosphere.m
%predicts good or bad weather based on 34 parameters
%Author: Antonio Peters

clc;
clear;

%import and normalise data
D   = fopen('ionosphere.dat');

D = textscan(D,'%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %c');

p = [D{1} D{2} D{1} D{3} D{4} D{5} D{6} D{7} D{8} D{9} D{10} D{11} D{12} D{13} D{14} D{15} D{16} D{17} D{18} D{19} D{20} D{21} D{22} D{23} D{24} D{25} D{26} D{27} D{28} D{29} D{30} D{31} D{32} D{33} D{34}]';

T = [D{35}]';

for i = 1:size(T,2)
    if T(i) == 'g'
        t(i) = 1;
    else
        t(i) = 0;
    end
end

%split into sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

%create net
net=newff(p,t,[5, 5, 3]);

%set goal>0
net.trainParam.goal=1e-8;
net=init(net);
[net,tr]=train(net,ptrain,ttrain);
ionnet=net;

%simulate
atrain=sim(ionnet,ptrain); %train
atest=sim(ionnet,ptest); %test
a=sim(ionnet,p); %all

atest = round(atest);

%degree of fit
r2 = rsq(ttest,atest)
[R,pv] = corrcoef(ttest,atest)

%plot results
x = 1:size(ttest,2);
plot(x,abs(ttest - atest));

save ionosphere.mat