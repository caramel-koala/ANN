%concrete.m
%Calcualtes concrete strength based on 8 attributes
%AUTHOR: Antonio Peters

clc;
clear;

%import and normalise data
D   = csvread('Concrete.csv');

p = D(:,1:8)';
t = D(:,9)';

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
            connet=net;

            %simulate
            atrain=sim(connet,ptrain); %train
            atest=sim(connet,ptest); %test
            a=sim(connet,p); %all

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

connet = bestnet;
atest   = sim(connet,ptest);

%degree of fit
r2=rsq(ttest,atest)
[R,pv]=corrcoef(ttest,atest)

%plot results
plot(ttest,ttest,'b',ttest,atest,'r*');

save concrete.mat

