%iris2rbn
%determines property value by 13 features using an RBF net
%Author: Antonio Peters

clc;
clear;

load housing.mat

%number of centers
m = 250;

%training index: choose m centers randomly
tri = randperm(506);
tri = tri(1:m);

%test index
ti  = setdiff(1:506,tri);

%training and test sets:
ptrain  = p(:,tri);
ttrain  = t(:,tri);
ptest   = p(:,ti);
ttest   = t(:,ti);

%max dist and spread
d   = max(max(dist(ptrain',ptrain)));
s   = d*sqrt(log(2))/sqrt(m);

%form the net:
net = newrb(ptrain,ttrain,0.01,s,m,1);

%simulate
atrain  = sim(net,ptrain);
atest   = sim(net,ptest);
atest   = round(atest,1);

%assess
%correct classifications:
cc  = sum(all((atest-ttest)==0));

%percentage correct
pc  = cc/(506-m)*100;
fprintf('percentage correct = %4.2f\n',pc)

%max dist and spread
d   = max(max(dist(ptrain',ptrain)));
ss  = d*sqrt(log(2))/sqrt(m);
S   = linspace(ss/2,ss*2,round(ss*2-ss/2));
C   = [];

for s=S
    %form the net: exact design
    net = newrb(ptrain,ttrain,0.01,s,m,1);
    
    %simulate
    atrain  = sim(net,ptrain);
    atest   = sim(net,ptest);
    atest   = round(atest,1);
    
    %assess
    %correct classifications on test set
    c   = sum(all((atest-ttest)<=0.1));
    
    %percentage correct
    pc  = c/(506-m)*100;
    C   = [C; s c pc];
end

disp(' spread correct %correct')
C

best    = max(C);
pc  = best(3);
fprintf('percentage correct = %4.2f\n',pc);

net = newrb(ptrain,ttrain,0.01,best(1),m,1);

a = sim(net,p);
a   = round(a,1);
plot(ttest,ttest,'b',ttest,atest,'r*')

%load and simulate the new data
pnew = [    0.0691    0.0136    0.1396    1.4139    0.0201    0.0482    0.0551    0.0430   41.5292    9.5136;
                 0   75.0000         0         0   95.0000   80.0000   33.0000   80.0000         0         0;
            2.1800    4.0000    8.5600   19.5800    2.6800    3.6400    2.1800    1.9100   18.1000   18.1000;
                 0         0         0    1.0000         0         0         0         0         0         0;
            0.4580    0.4100    0.5200    0.8710    0.4161    0.3920    0.4720    0.4130    0.6930    0.7130;
            7.1470    5.8880    6.1670    6.1290    8.0340    6.1080    7.2360    5.6630    5.5310    6.7280;
           54.2000   47.6000   90.0000   96.0000   31.9000   32.0000   41.1000   21.9000   85.4000   94.1000;
            6.0622    7.3197    2.4210    1.7494    5.1180    9.2203    4.0220   10.5857    1.6074    2.4961;
            3.0000    3.0000    5.0000    5.0000    4.0000    1.0000    7.0000    4.0000   24.0000   24.0000;
          222.0000  469.0000  384.0000  403.0000  224.0000  315.0000  222.0000  334.0000  666.0000  666.0000;
           18.7000   21.1000   20.9000   14.7000   14.7000   16.4000   18.4000   22.0000   20.2000   20.2000;
          396.9000  396.9000  392.6900  321.0200  390.5500  392.8900  393.6800  382.8000  329.4600    6.6800;
            5.3300   14.8000   12.3300   15.1200    2.8800    6.5700    6.9300    8.0500   27.3800   18.7100];

anew = sim(net,pnew)