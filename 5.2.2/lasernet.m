%lasernet.m
%uses sliding window to predict laser intensity
%Author: Antonio Peters

clc;
clear;

%get data
load laser.mat

%set p's and t's
for i = 1:length(y)-8
    p(:,i) = y(i:i+7);
end
ptrain  = p(:,1:end-10);
ptest   = p(:,end-9:end);

t       = y(9:end)';
ttrain  = y(9:end-10)';
ttest   = y(end-9:end)';

%set layer sizes
s1 = 9;
s2 = 9;

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
save lasernet.mat