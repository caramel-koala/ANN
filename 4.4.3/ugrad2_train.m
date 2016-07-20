%ugrad2_train
clc
clear
close all
%arrange the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data=importdata('ugraddata5.txt');
P=Data(:,[1 2 3]);
T=Data(:,[4 5]);
%arrange as rows
p=P';
t=T';
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
W1=randu(-1,1,s1,r);
b1=randu(-1,1,s1,1);
W2=randu(-1,1,s2,s1);
b2=randu(-1,1,s2,1);
W3=randu(-1,1,s3,s2);
b3=randu(-1,1,s3,1);
%transfer functions
f1=@tansig;
f2=@logsig;
f3=@purelin;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Training parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%learning rate
h=.05;
%epoch counter
k=1;
%Initiate error for epoch
mse=1;
%collect errors in EE
E(1)=mse;

%set tolerance
tol =1e-8;
%max iterations
maxit=80000;

%train on normalised data: p1n, t1n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while mse>tol & k<maxit
k=k+1;
j = randi([1 length(p1n)],1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEW STUFF HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%propagate input patterns through the net
n1=W1*p1n(:,j)+b1;
a1=f1(n1);
n2=W2*a1+b2;
a2=f2(n2);
n3=W3*a2+b3;
a3=f3(n3);
an(:,j)=a3;
%j th error vector
e(:,j)=t1n(:,j)-an(:,j);
%derivative matrices
D3=eye(s3);
D2=diag((1-a2).*a2);
D1=diag(1-a1.^2);
%sensitivity vectors
S3=-2*D3*e(:,j);
S2=D2*W3'*S3;
S1=D1*W2'*S2;
%store sensitivities
SS([1:s1],k-1,1)=S1;
SS([s1+1:s1+s2],k-1)=S2;
SS([s1+s2+1:s1+s2+s3],k-1)=S3;
%update weights and biases
W3=W3-h*S3*a2';
b3=b3-h*S3;
W2=W2-h*S2*a1';
b2=b2-h*S2;
W1=W1-h*S1*p1n(:,j)';
b1=b1-h*S1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NEW STUFF ENDS HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%error for epoch
mse=sum(sum(e).^2)/q1;
%accumulate MSE into vector: EE
E(k)=mse;
end
ds=input('display sensitivities? 1=yes 0=no ');
if ds==1
disp('The initial and final sensitivites are:')
SS(:,[1:10, end-10:end])
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
save ugrad2_train.mat