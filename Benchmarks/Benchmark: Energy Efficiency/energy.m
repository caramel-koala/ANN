%energy.m
%predicts energy load of a room based on 8 parameters
%Author: Antonio Peters

clc;
clear;

%import and normalise data
D = csvread('energy.csv');

p = D(:,1:8)';
t = D(:,9:10)';

%number of centers per type
m   = round(size(p,2)*0.4);

%training index: choose m centers randomly
tri = randperm(size(p,2));
tri = tri(1:m);

%test index
ti  = setdiff(1:size(p,2),tri);

%training and test sets:
ptrain  = p(:,tri);
ttrain  = t(:,tri);
ptest   = p(:,ti);
ttest   = t(:,ti);

%max dist and spread
d   = max(max(dist(ptrain',ptrain)));
ss   = d*sqrt(log(2))/sqrt(m);
S   = linspace(ss-.2,ss+.2,11);
C   = [];

for s=S
    %form the net:
    energynet = newrb(ptrain,ttrain,0.3,s,m,1);

    %simulate
    atrain  = sim(energynet,ptrain);
    atest   = sim(energynet,ptest);
    
    %assess
    %correct classifications on test set
    c   = sum(all((atest-ttest)==0));
    
    %percentage correct
    pc  = c/(size(p,2)-m)*100;
    C   = [C; s c pc];
end

%train on the best net
best = max(C);
s = best(1);
energynet = newrb(ptrain,ttrain,0.3,s,m,1);
atest   = sim(energynet,ptest);

%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

atest = round(atest);

%plot results
plot(ttest(1,:),ttest(1,:),'b',ttest(1,:),atest(1,:),'r*');
figure;
plot(ttest(2,:),ttest(2,:),'b',ttest(2,:),atest(2,:),'r*');

save energy.mat