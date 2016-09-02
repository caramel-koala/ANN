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

%run through the net
y = schoolnet(x);

%plots
figure
plot(x(2,:),y(1,:))
title('Final Mark vs School Quality')
figure
plot(x(1,:),y(1,:))
title('Final Mark vs Swedish points')