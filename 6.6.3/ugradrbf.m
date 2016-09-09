%ugrad.m
%uses an RBF net to model undergrad performace
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

%test index
m   = size(p,2);
I   = randperm(m);
ti  = I(1:floor(m/5));

%training index
tri = setdiff([1:m],ti);

%training and test sets:
ptrain  = p(:,tri);
ttrain  = t(:,tri);
ptest   = p(:,ti);
ttest   = t(:,ti);

d   = dist(p',p);
dm  = max(max(d));
fprintf('max distance between inputs = %4.2f\n',dm)

%spread range 
sr  = [.1,10];

R   = [];
for s = sr(1):.1:sr(2)
    %train on training set
    net = newrbe(ptrain,ttrain,s);
    %simulate on test set
    a   = sim(net,ptest);
    [r, ~]  = corrcoef(ttest,a);
    r   = r(1,2);
    r2  = rsq(ttest,a);
    R   = [R;[s r2(1)+r2(2) r]];
end

disp(' spread r2 r');
fprintf('%8.4f\t%-8.4f\t%-8.4f\n',R');

%find the best spread wrt r2 stat
[mr2,i] = max(R(:,2));
bs2 = R(i,1);

%simulate with best spread
net = newrbe(ptrain,ttrain,bs2);
a   = sim(net,p);
[r, ~]  = corrcoef(t,a);
r   = r(1,2);
r2  = rsq(t,a);

%Plots:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t11=t(1,:);
a11=a(1,:);
t12=t(2,:);
a12=a(2,:);
figure
hold on
plot(t11,t11)
plot(t11,a11,'*')
title(sprintf('Training: Semester 1 with spread = %g\n',bs2))
hold off
figure
hold on
plot(t12,t12)
plot(t12,a12,'*')
hold off
title(sprintf('Training: Semester 2 with spread = %g\n',bs2))