%alphsbetnet.m
%recognises patterns for: A to Z
%when the patterns contain errors,
%the net returns the best approximation to the pattern.
%Author: Antonio Peters

clc;
clear;

%input
[P,T] = prprob;

p   = repmat(P,1,25);

%disturb data
r   = randi([1,size(P,1)],1,size(p,2)-size(P,2));

for i = size(P,2)+1:size(p,2)
    if p(r(i-size(P,2)),i) == 0
        p(r(i-size(P,2)),i) = 1;
    else
        p(r(i-size(P,2)),i) = 0;
    end
end

%targets
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
alphnet=net;

q1=size(ptrain,2);
%using our own hand-made net:
q2=size(ptest,2);
%simulate
atrain=sim(alphnet,ptrain); %train
atest=sim(alphnet,ptest); %test
a=sim(alphnet,p); %all

%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

save alphabet.mat