%wine.m
%predicts the quality of wine based on 11 parameters
%Author: Antonio Peters

clc;
clear;

%import and normalise data
D = fopen('seeds.dat');

D = textscan(D,'%f %f %f %f %f %f %f %f');

p = [D{1} D{2} D{1} D{3} D{4} D{5} D{6} D{7}]';
T = D{8}';

t = zeros(3,length(T));

for i = 1:length(T)
    if T(i) == 1
        t(:,i) = [1 0 0]';
    elseif T(i) == 2
        t(:,i) = [0 1 0]';
    else
        t(:,i) = [0 0 1]';
    end
end

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
        
        for k = 1:size(S,2)
            
            s = [i,j,k];

            %create the net
            net=newff(ptrain,ttrain,s);

            %set goal>0
            net.trainParam.goal=1e-8;
            net=init(net);
            [net,tr]=train(net,ptrain,ttrain);
            seednet=net;

            %simulate
            atrain=sim(seednet,ptrain); %train
            atest=sim(seednet,ptest); %test
            a=sim(seednet,p); %all

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

seednet = bestnet;

%simulate
atrain=sim(seednet,ptrain); %train
atest=sim(seednet,ptest); %test
a=sim(seednet,p); %all

atest = round(atest);
        
r2=rsq(ttest,atest)
[R,PV]=corrcoef(ttest,atest)

for i = 1:size(ttest,2)
    if ttest(:,i) == [1 0 0]'
        tp(i) = 1;
    elseif ttest(:,i) == [0 1 0]'
        tp(i) = 2;
    elseif ttest(:,i) == [0 0 1]'
        tp(i) = 3;
    else tp(i) = 0;
    end
    
    if atest(:,i) == [1 0 0]'
        ap(i) = 1;
    elseif atest(:,i) == [0 1 0]'
        ap(i) = 2;
    elseif atest(:,i) == [0 0 1]'
        ap(i) = 3;
    else ap(i) = 0;
    end
end

%plot results
x = 1:length(tp);
plot(x,tp,'bo',x,ap,'r*');
save seed.mat