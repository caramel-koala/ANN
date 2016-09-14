%ionosphere.m
%uses a net to predict foF2 levels in the ionospehre
%Author: Antonio Peters

clc;

clear;

D = fopen('iondata.txt');

D = textscan(D,'%f,%f,%f,%f');

p = [ cos(2*pi*(D{1}/365)) sin(2*pi*(D{1}/365)) D{2} D{3}]';
t = D{4}';

%split into sets
[ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
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
        
        s = [i,j];

        %create the net
        net=newff(ptrain,ttrain,s);

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

        r2=rsq(ttest,atest);
        [R,PV]=corrcoef(ttest,atest);
        %-------------------------------------------------
        Corr(i,j)=R(1,2);
        R2(i,j,:)=r2;
        if (abs(R(1,2))+sum(r2) > bestcandr)
            bestcandr = abs(R(1,2))+r2;
            bestlay = [i,j];
            bestnet = ionnet; %sets the best net
        end
    end
end

ionnet = bestnet;

%simulate
atrain=sim(ionnet,ptrain); %train
atest=sim(ionnet,ptest); %test
a=sim(ionnet,p); %all

%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

%plot results
x = 1:size(ttest,2);
plot(x,ttest,'bo',x,atest,'r*');

save ionosphere.mat