%metalnet.m
%uses a rolling average prediction to predict the price of metal;

clc;
clear;

x = csvread('metals.csv');

netlist = [];

for j=1:size(x,2)
    
    sl = 50; %slide window
    %set p's and t's
    for i = 1:size(x,1)-sl
        p(:,i) = x(i:i+sl-1,j);
    end
    ptrain  = p(:,1:end-10);
    ptest   = p(:,end-9:end);

    t       = x(sl+1:end,j)';
    ttrain  = t(1:end-10);
    ttest   = t(end-9:end);

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
    metnet=net;

    %activations
    atrain=sim(metnet,ptrain);
    atest=sim(metnet,ptest);
    a=sim(metnet,p);
    %degree of fit
    r2=rsq(ttest,atest)
    [R,pv]=corrcoef(ttest,atest);
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
    
    netlist = [netlist net];

end

save metals.mat