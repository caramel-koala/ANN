%ugrad.m
%uses a momentum based neural net to model undergrad performace
%Author: Antonio Peters
clc
clear
close all
%arrange the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data=importdata('ugraddata5.txt');
p=Data(:,[1 2 3])';
t=Data(:,[4 5])';
%check:
[r,q]=size(p);
[s,qt]=size(t);
if q~=qt
error('different batch sizes');
end

%scale down:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%scale down inputs by row
pM=max(p')'; %row maxima
pm=min(p')'; %row minima
pf=2./(pM-pm); %factors to scale down rows
pc=-(pM+pm)./(pM-pm); %additive terms
Dp=diag(pf); %pf down the diagonal of Dp
pn=Dp*p+repmat(pc,1,size(p,2)); %scale down
%scale down targets similarly
tM=max(t')' ;
tm=min(t')';
tf=2./(tM-tm);
tc=-(tM+tm)./(tM-tm);
Dt=diag(tf);
tn=Dt*t+repmat(tc,1,size(t,2));

%train index
I1=randperm(floor(2*q/3));
q1=length(I1);
%test index
I2=setdiff([1:q],I1);
q2=length(I2);
%training set:
p1=p(:,I1);
t1=t(:,I1);
p1n=pn(:,I1);
t1n=tn(:,I1);
%test set
p2=pn(:,I2);
t2=t(:,I2);
p2n=pn(:,I2);
t2n=tn(:,I2);

%
%network architecture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% W1(s1Xr) W2(s2Xs1) W3(s3Xs2)
% p(2Xq)---------->a1 ------------->a2----------->----->a3(s3Xq)
% b1(s1X1) b2(s2Xs1) b3(s3Xs2)
%
% tansig logsig purelin

%layer sizes:
s1=9;
s2=9;
s3=s;

%initialise
k = 1; %epoch counter
h=.07;%learning rate
m = 0.5;%momentum

W1 = randu(-1,1,s1,r);
b1 = randu(-1,1,s1,1);
W2 = randu(-1,1,s2,s1);
b2 = randu(-1,1,s2,1);
W3 = randu(-1,1,s3,s2);
b3 = randu(-1,1,s3,1);
%transfer functions
f1 = @tansig;
f2 = @logsig;
f3 = @purelin;

%first propagation
for j = 1:q1
    n1 = W1*p1n(:,j) + b1;
    a1 = f1(n1);
    n2 = W2*a1 + b2;
    a2 = f2(n2);
    n3 = W3*a2 + b3;
    a3 = f3(n3);
    an(:,j)=a3;

    %error vector for the data
    e(:,j) = t1n(:,j) - an(:,j);

    %derivative matrices
    D3 = eye(s3);
    D2 = diag((1-a2).*a2);
    D1 = diag(1-a1.^2);
    %sensitivity vectors
    S3 = -2*D3*e(:,j);
    S2 = D2*W3'*S3;
    S1 = D1*W2'*S2;

    %first update
    W3 = W3 - h*S3*a2';
    b3 = b3 - h*S3;
    W2 = W2 - h*S2*a1';
    b2 = b2 - h*S2;
    W1 = W1 - h*S1*pn(:,j)';
    b1 = b1 - h*S1;
    
    W3o = W3;
    b3o = b3;
    W2o = W2;
    b2o = b2;
    W1o = W1;
    b1o = b1;

end

%error for the epoch
mse = sum(sum(e).^2)/q1;
E(k) = mse;

tol = 1e-8;
maxit = 800;

while mse>tol && k<maxit
    k=k+1;
    %run the batch
    for j=1:q1
        %propogate
        n1 = W1*p1n(:,j) + b1;
        a1 = f1(n1);
        n2 = W2*a1 + b2;
        a2 = f2(n2);
        n3 = W3*a2 + b3;
        a3 = f3(n3);
        an(:,j)=a3;

        %error vector for the data
        e(:,j) = t1n(:,j) - an(:,j);

        %derivative matrices
        D3 = eye(s3);
        D2 = diag((1-a2).*a2);
        D1 = diag(1-a1.^2);
        %sensitivity vectors
        S3 = -2*D3*e(:,j);
        S2 = D2*W3'*S3;
        S1 = D1*W2'*S2;
    
        %update
        W3n = W3 - h*S3*a2'      + m*(W3 - W3o);
        b3n = b3 - h*S3          + m*(b3 - b3o);
        W2n = W2 - h*S2*a1'      + m*(W2 - W2o);
        b2n = b2 - h*S2          + m*(b2 - b2o);
        W1n = W1 - h*S1*pn(:,j)' + m*(W1 - W1o);
        b1n = b1 - h*S1          + m*(b1 - b1o);
        
        W3o = W3;
        b3o = b3;
        W2o = W2;
        b2o = b2;
        W1o = W1;
        b1o = b1;
        W3 = W3n;
        b3 = b3n;
        W2 = W2n;
        b2 = b2n;
        W1 = W1n;
        b1 = b1n;
        
    end
    %error vector for the data
    e = t1n - an;
    %error for the epoch
    mse = sum(sum(e).^2)/q1;
    E(k) = mse;
end

%scale up
a=diag(1./tf)*( an-repmat(tc,1,size(t1,2)) );

%assessing the degree of fit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%R^2 statistic
r2=rsq(t1,a);
%corrcoeff
[R1,PV1]=corrcoef(a(1,:),t1(1,:));
fprintf('Training: Semester 1:\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n',R1(1,2),PV1(1,2),r2(1))
disp('----------------------------------------------------------------------')
[R2,PV2]=corrcoef(a(2,:),t1(2,:));
fprintf('Training: Semester 2\n\n')
fprintf(' corr coeff: %g\n p value: %g\n r2: %g\n\n',R2(1,2),PV2(1,2),r2(2))
disp('----------------------------------------------------------------------')

%Plots:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t11=t1(1,:);
a11=a(1,:);
t12=t1(2,:);
a12=a(2,:);
%plot error (performance function)
close all
E=E(2:end);
plot(E);
title('MSE')
figure
hold on
plot(t11,t11)
plot(t11,a11,'*')
title(sprintf('Training: Semester 1 with %g samples\n',q))
hold off
figure
hold on
plot(t12,t12)
plot(t12,a12,'*')
hold off
title(sprintf('Training: Semester 2 with %g samples\n',q))

%compare with linear model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp('Compare with linear model')
%find that M such that ||Mp-t|| is a minimum
M=t/p;
%activate using M
L=M*p;
L1=L(:,I1);
figure
hold on
plot(t11,t11)
plot(t11,L1(1,:),'*')
title('linear model: first semester')
hold off
figure
hold on
plot(t12,t12)
plot(t12,L1(2,:),'*')
title('linear model: second semester')

L21=rsq(t1,L1)
fprintf('Training: Linear fit Semester 1 %g\n',L21(1))
fprintf('Training: Linear fit Semester 2 %g\n',L21(2))

%save variables
save ugrad.mat