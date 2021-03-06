%ts2_test.m
%uses sliding window to predict random numbers
%Author: Antonio Peters

clc;
clear;

%generate data
x = randu(1,100,[1,100]);

sl = 10;

%set p's and t's
for i = 1:length(x)-sl
    p(:,i) = x(i:i+sl-1);
end
ptrain  = p(:,1:end-sl);
ptest   = p(:,end-sl+1:end);

t       = x(sl+1:end);
ttrain  = x(sl+1:end-sl);
ttest   = x(end-sl+1:end);

%set layer sizes
s1 = 20;
s2 = 20;

%create net
net = newff(ptrain,ttrain,[s1,s2]);

%Net training
net.TrainParam.epochs=1000;

%training
net.trainFcn='trainscg';
net.trainParam.max_fail=40;

%initiate the weights and biases
net=init(net);

%train the net
[net,netstr]=train(net,ptrain,ttrain);

%rename
rngnet=net;

%activations
atrain=sim(net,ptrain);
atest=sim(net,ptest);
a=sim(net,p);
%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)
figure
plot(ttest,ttest,ttest,atest,'.')
title('test')
figure
hold on
plot([1:length(atest)],ttest,'o')
plot([1:length(atest)],atest,'.')
hold off
title(sprintf('activation on test set'))
figure
%myfigureposition(pos2)
plot([1:length(a)],a,[1:length(a)],t,'o')
title('activalion on all')
save rng.mat