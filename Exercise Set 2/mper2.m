%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mper2.m
%creates trains and save a specific classification problem
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%Pattern
P   = [-.2  -.2 -.3 .2  .2  .3  .6  .7  .8  1.1 1.2 1.3;
       -.2  -.3 -.2 .2  .3  .2  .6  .8  .7  1.2 1.3 1.1];
   
%resize P to remove need for b
P   = [P;ones(1,size(P,2))];

%Target
T   = [ 0   0   0   0   0   0   1   1   1   1   1   1;
        0   0   0   1   1   1   0   0   0   1   1   1];