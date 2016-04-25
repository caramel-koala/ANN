%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%backpropdemo.m
%Main launcher for all backpropdemo questions
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all
%generate inputs and targets
p=[0:pi/4:2*pi]';
t=3*sin(2*p)+1;

%tolerance
tol=.001;

%rescale p and t
[up, ap, bp] = scale(p);
[ut, at, bt] = scale(t);

%Call function
str = input('Which demo would you like to run: ','s');
if str=='1a'
    [E,ua] = backpropdemo1a(up,ut,tol);
elseif str=='1b'
    [E,ua] = backpropdemo1b(up,ut,tol);
elseif str=='2a'
    [E,ua] = backpropdemo2a(up,ut,tol);
elseif str=='2b'
    [E,ua] = backpropdemo2b(up,ut,tol);
elseif str=='3a'
    [E,ua] = backpropdemo3a(up,ut,tol);
elseif str=='3b'
    [E,ua] = backpropdemo3b(up,ut,tol);
end

a = diag(1./at)*( ua - repmat(bt,1,size(bt,2)) );

figure
plot(E);
xlabel('iterations');
ylabel('E');
title(sprintf('Performance with tolerance = %g\n',tol));
rsq= r2(a,t);
%compare with function
x=linspace(0,2*pi,101);
y=3*sin(2*x)+1;
figure
plot(p,t,'o')
hold on
plot(p,a,'*')
plot(x,y)
hold off
title(sprintf('activation vs targets r2 stat = %g\n',rsq))