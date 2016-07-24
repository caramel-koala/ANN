%Deploys ugrad2net
%Author: Antonio Peters

clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a

%vary Swedish points
x(1,:)=linspace(24,46,100);
%vary school quality
x(2,:)= linspace(1,10,100);
%fix test results
x(3,:)=50*ones(100,1);
%deploy the net
y=ugrad2net(x);
%plots
figure
plot(x(2,:),y(1,:))
title('semester 1 vs School Quality for a fixed test result of 50')
figure
plot(x(2,:),y(2,:))
title('semester 2 vs School Quality for a fixed test result of 50')
figure
plot(x(1,:),y(1,:))
title('semester 1 vs Swedish points for a fixed test result of 50')
figure
plot(x(1,:),y(2,:))
title('semester 2 vs Swedish points for a fixed test result of 50')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%b

%Fix Swedish points
xb(1,:)=30*ones(100,1);
%vary school quality
xb(2,:)= linspace(1,10,100);
%vary test results
xb(3,:)=1:100;
%deploy the net
yb=ugrad2net(xb);
%plots
figure
plot(xb(2,:),yb(1,:))
title('semester 1 vs School Quality for a fixed Swedish points of 30')
figure
plot(xb(2,:),yb(2,:))
title('semester 2 vs School Quality for a fixed Swedish points of 30')
figure
plot(xb(3,:),yb(1,:))
title('semester 1 vs Test results for a fixed Swedish points of 30')
figure
plot(xb(3,:),yb(2,:))
title('semester 2 vs Test results for a fixed Swedish points of 30')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c

%Fix Swedish points
xc(1,:)=25*ones(100,1);
%vary school quality
xc(2,:)= 6*ones(100,1);
%vary test results
xc(3,:)=1:100;
%deploy the net
yb=ugrad2net(xb);
%plots
figure
plot(xb(3,:),yb(1,:))
title('semester 1 vs Test results for a fixed Swedish points of 25 and School Quality of 6')
figure
plot(xb(3,:),yb(2,:))
title('semester 2 vs Test results for a fixed Swedish points of 25 and School Quality of 6')