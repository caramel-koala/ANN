%iris2rbn
%determines flower type by 4 features using an RBF net
%Author: Antonio Peters

clc;
clear;

%load and organise the data
D   = fopen('irisdata.dat');

P = textscan(D,'%f,%f,%f,%f,%s');

%input patterns p is 150 X 4
%patterns are the ROWS
%arrrange as cols
p   = [P{1} P{2} P{3} P{4}]';

%targets t is 3 X 150
t   = [repmat([1;0;0],1,50) repmat([0;1;0],1,50) repmat([0;0;1],1,50)];

%number of centers per type
m   = 10;

%training index: choose m centers randomly
tri = randperm(50);
tri = tri(1:m);

%test index
ti  = setdiff(1:50,tri);

%training and test sets:
ptrain  = [p(:,tri) p(:,50+tri) p(:,100+tri)];
ttrain  = [t(:,tri) t(:,50+tri) t(:,100+tri)];
ptest   = [p(:,ti)  p(:,50+ti)  p(:,100+ti) ];
ttest   = [t(:,ti)  t(:,50+ti)  t(:,100+ti) ];

%max dist and spread
d   = max(max(dist(ptrain',ptrain)));
s   = d*sqrt(log(2))/sqrt(m);

%form the net:
net = newrb(ptrain,ttrain,0.3,s,m,1);

%simulate
atrain  = sim(net,ptrain);
atest   = sim(net,ptest);
atest   = round(atest);

%assess
%correct classifications:
cc  = sum(all((atest-ttest)==0));

%percentage correct
pc  = cc/(150-m)*100;
fprintf('percentage correct = %4.2f\n',pc)

%max dist and spread
d   = max(max(dist(ptrain',ptrain)));
ss  = d*sqrt(log(2))/sqrt(m);
S   = linspace(ss-.2,ss+.2,11);
C   = [];

for s=S
    %form the net: exact design
    net = newrb(ptrain,ttrain,0.3,s,m,1);
    
    %simulate
    atrain  = sim(net,ptrain);
    atest   = sim(net,ptest);
    atest   = round(atest);
    
    %assess
    %correct classifications on test set
    c   = sum(all((atest-ttest)==0));
    
    %percentage correct
    pc  = c/(150-m)*100;
    C   = [C; s c pc];
end

disp(' spread correct %correct')
C

best    = max(C);
pc  = best(3);
fprintf('percentage correct = %4.2f\n',pc)
