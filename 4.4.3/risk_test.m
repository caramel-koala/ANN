%risk_test.m
%tests the net risk_train.mat
%Author: Antonio Peters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%a)

clear all
close all
clc

%vary age
x(1,:) = 0.6*ones(101,1);
%vary BMI
x(2,:) = linspace(0,1,101);
%vary genetic
x(3,:) = linspace(0,1,101);
%vary fitness
x(4,:) = linspace(0,1,101);

%run net on x
y = risknet(x);

%plot
figure
plot(x(2,:),y(1,:))
title('Risk vs BMI for fixed age of 0.6')
figure
plot(x(3,:),y(1,:))
title('Risk vs Genetics for fixed age of 0.6')
figure
plot(x(4,:),y(1,:))
title('Risk vs Fitness for fixed age of 0.6')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%b)

clear all
close all
clc

%vary age
x(1,:) = linspace(0,1,101);
%vary BMI
x(2,:) = 0.8*ones(101,1);
%vary genetic
x(3,:) = linspace(0,1,101);
%vary fitness
x(4,:) = linspace(0,1,101);

%run net on x
y = risknet(x);

%plot
figure
plot(x(1,:),y(1,:))
title('Risk vs Age for fixed BMI of 0.8')
figure
plot(x(3,:),y(1,:))
title('Risk vs Genetics for fixed BMI of 0.8')
figure
plot(x(4,:),y(1,:))
title('Risk vs Fitness for fixed BMI of 0.8')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c)

clear all
close all
clc

%vary age
x(1,:) = linspace(0,1,101);
%vary BMI
x(2,:) = linspace(0,1,101);
%vary genetic
x(3,:) = 0.5*ones(101,1);
%vary fitness
x(4,:) = linspace(0,1,101);

%run net on x
y = risknet(x);

%plot
figure
plot(x(1,:),y(1,:))
title('Risk vs Age for fixed genetic factor of 0.5')
figure
plot(x(2,:),y(1,:))
title('Risk vs BMI for fixed genetic factor of 0.5')
figure
plot(x(4,:),y(1,:))
title('Risk vs Fitness for fixed genetic factor of 0.5')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%d)

clear all
close all
clc

%vary age
x(1,:) = linspace(0,1,101);
%vary BMI
x(2,:) = linspace(0,1,101);
%vary genetic
x(3,:) = linspace(0,1,101);
%vary fitness
x(4,:) = 0.1*ones(101,1);

%run net on x
y = risknet(x);

%plot
figure
plot(x(1,:),y(1,:))
title('Risk vs Age for fixed fitness of 0.1')
figure
plot(x(2,:),y(1,:))
title('Risk vs BMI for fixed fitness of 0.1')
figure
plot(x(3,:),y(1,:))
title('Risk vs Genetics for fixed fitness of 0.1')
