%school_test
%Tests the neural net made in school_train.m
%Author: Antonio Peters
%Modefied by adapting ugradnet and ugrad2_sim

clear all
close all
clc

%vary Swedish points
x(1,:)=linspace(24,46,100);
%vary school quality
x(2,:)= linspace(1,10,100);
%deploy the net
load school_train.mat
if size(x,1)~=r
error('x incorrect size');
end
%normalise x
xn=Dp*x+repmat(pc,1,size(x,2));
for j=1:size(x,2)
n1=W1*xn(:,j)+b1;
a1=f1(n1);
n2=W2*a1+b2;
a2=f2(n2);
yn(:,j)=a2;
end
y=diag(1./tf)*( yn-repmat(tc,1,size(yn,2)) );

%plots
figure
plot(x(2,:),y(1,:))
title('Final Mark vs School Quality')
figure
plot(x(1,:),y(1,:))
title('Final Mark vs Swedish points')