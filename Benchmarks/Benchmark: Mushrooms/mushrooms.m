%mushrooms.m
%Classifies mushrooms based on 22 attributes
%AUTHOR: Antonio Peters

clc;
clear;

%import and normalise data
D   = fopen('mushrooms.dat');

D = textscan(D,'%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c,%c');

P = [D{2} D{1} D{3} D{4} D{5} D{6} D{7} D{8} D{9} D{10} D{11} D{12} D{13} D{14} D{15} D{16} D{17} D{18} D{19} D{20} D{21} D{22} D{23}]';

T = D{1}';

for i = 1:size(P,2)
    for j = 1:size(P,1)
        pi(j,i) = double(P(j,i)) - 97; %converts characters to integers
    end
    if T(i) == 'e'
        tp(i) = 1;
    else
        tp(i) = 0;
    end
end

p = [];
t = [];

%remove all incomplete p-values
for i = 1:size(pi,2)
    j = find(pi(:,i)<0);
    if isempty(j)
        p = [p, pi(:,i)];
        t = [t, tp(:,i)];
    end
end

%split into sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.65,0,0.25);
[ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);


%layer sizes
S=[1:20];

%matrix to store assessments
Corr = zeros(size(S,2),size(S,2),3);
R2   = zeros(size(S,2),size(S,2),3);

%variables for the best fitting net
bestcandr = 0; %corr coeff and %r2 value
bestlay = [1,1]; %layer sizes

for i=1:size(S,2)
    
    for j=1:size(S,2)
        
        for k = 1:size(S,2)
            
            s = [i,j,k];

            %create the net
            net=newff(ptrain,ttrain,s);

            %set goal>0
            net.trainParam.goal=1e-8;
            net=init(net);
            [net,tr]=train(net,ptrain,ttrain);
            mushnet=net;

            %simulate
            atrain=sim(mushnet,ptrain); %train
            atest=sim(mushnet,ptest); %test
            a=sim(mushnet,p); %all

            atest = round(atest);

            r2=rsq(ttest,atest);
            [R,PV]=corrcoef(ttest,atest);
            %-------------------------------------------------
            Corr(i,j)=R(1,2);
            R2(i,j,:)=r2;
            if (abs(R(1,2))+sum(r2) > bestcandr)
                bestcandr = abs(R(1,2))+r2;
                bestlay = [i,j,k];
                bestnet = net; %sets the best net
            end
        end
    end
end

mushnet = bestnet;

%simulate
atrain=sim(mushnet,ptrain); %train
atest=sim(mushnet,ptest); %test
a=sim(mushnet,p); %all

%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

atest = round(atest);

%plot results
x = 1:size(ttest,2);
plot(x,ttest - atest);

save mushrooms.mat