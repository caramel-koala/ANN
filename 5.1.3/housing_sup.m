%housing_sup
clear
close all
clc

load housing.mat
[r,q]=size(p);

%network architecture

%layer sizes
S=[1:50];

%matrix to store assessments
Corr = zeros(size(S,2));
R2   = zeros(size(S,2));

%variables for the best fitting net
bestcandr = 0; %corr coeff and %r2 value
bestlay = [1,1]; %layer sizes

for i=1:size(S,2)
    
    s1=S(i);
    
    for j=1:size(S,2)
        
        s2=S(j);
    
        %create the net
        net=newff(p,t,[s1,s2]);

        %display(net)
        %training
        net.trainFcn='trainscg';

        %maxit
        net.trainParam.epochs=800;

        %set the number of epochs that the error on the validation set increses
        net.trainParam.max_fail=20;

        %We can also set using:
        [ptrain,pval,ptest,trainInd,valInd,testInd] = dividerand(p,0.6,0.2,0.2);
        [ttrain,tval,ttest] = divideind(t,trainInd,valInd,testInd);

        %initiate
        net=init(net);

        %train
        [net,netstruct]=train(net,p,t);

        %name the net and structure
        net.userdata='housing';
        housingnet=net;
        housingstruct=netstruct;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        q1=size(ptrain,2);
        %using our own hand-made net:
        q2=size(ptest,2);
        %simulate
        atrain=sim(housingnet,ptrain); %train
        atest=sim(housingnet,ptest); %test
        a=sim(housingnet,p); %all
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %assessing the degree of fit
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %test:
        r2=rsq(ttest,atest);
        [R,PV]=corrcoef(ttest,atest);
        %-------------------------------------------------
        Corr(i,j)=R(1,2);
        R2(i,j)=r2;
        if (abs(R(1,2))+r2 > bestcandr)
            bestcandr = abs(R(1,2))+r2;
            bestlay = [i,j];
            bestnet = net; %sets the best net
        end
        
    end
end

s1=bestlay(1);
s2=bestlay(2);
    
%name the net and structure
bestnet.userdata='housing';
housingnet=bestnet;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q1=size(ptrain,2);
%using our own hand-made net:
q2=size(ptest,2);
%simulate
atrain=sim(housingnet,ptrain); %train
atest=sim(housingnet,ptest); %test
a=sim(housingnet,p); %all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%assessing the degree of fit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%train
r2=rsq(ttrain,atrain);
[R,PV]=corrcoef(ttrain,atrain);
fprintf('Training:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(ttrain,ttrain,ttrain,atrain,'*')
title(sprintf('training: With %g samples s1=%g,s2=%g\n',q,s1,s2))
%-------------------------------------------------------------
%test:
r2=rsq(ttest,atest);
[R,PV]=corrcoef(ttest,atest);
fprintf('Testing:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R(1,2),PV(1,2),r2)
disp('----------------------------------------------------------------------')
figure
plot(ttest,ttest,ttest,atest,'*')
title(sprintf('Testing: With %g samples s1=%g,s2=%g\n',q,s1,s2))
%-------------------------------------------------

save housingnet.mat;