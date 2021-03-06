%numbers.m
%recognises patterns for: zero to nine
%when the patterns contain errors,
%the net returns the best approximation to the pattern.
%Author: Antonio Peters

clc;
clear;

%input
load numbersdata.mat

%linearise numbers
P   = [ number_0(:) number_1(:) number_2(:) number_3(:) number_4(:) number_5(:) number_6(:) number_7(:) number_8(:) number_9(:)];

p   = repmat(P,1,25);

%disturb data
r   = randi([1,25],1,size(p,2)-size(P,2));

for i = size(P,2)+1:size(p,2)
    if p(r(i-size(P,2)),i) == 0
        p(r(i-size(P,2)),i) = 1;
    else
        p(r(i-size(P,2)),i) = 0;
    end
end

%targets
T=eye(size(P,2));
t = repmat(T,1,25);

%split into sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);


%create net
net=newff(p,t,[30, 30]);
net.divideFcn='';

%set goal>0
net.trainParam.goal=1e-8;
net=init(net);
[net,tr]=train(net,ptrain,ttrain);
numnet=net;

q1=size(ptrain,2);
%using our own hand-made net:
q2=size(ptest,2);
%simulate
atrain=sim(numnet,ptrain); %train
atest=sim(numnet,ptest); %test
a=sim(numnet,p); %all

%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

save numbers.mat