clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a

%vary Swedish points
x(1,:)=linspace(24,46,10);
%vary school quality
x(2,:)= 1:10;
%fix test results
x(3,:)=50*ones(10,1);
%deploy the net
y=ugradnet(x)
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
%a

%Fix Swedish points
x(1,:)=30*ones(10,1);
%vary school quality
x(2,:)= 1:10;
%vary test results
x(3,:)=50*ones(10,1);
%deploy the net
y=ugradnet(x)
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