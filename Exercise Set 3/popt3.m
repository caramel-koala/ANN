%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.8.3 [2]
% popt3.m
% Descends to the minimum of a function from a given starting point.
%Author: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Get starting point
while true
	P	= input('Starting Points:');
	if length(P) ~= 2
		P 	= [	1,  0];
    end
    
    if P(1) <= 1 && P(1) >= -1 && P(2) >= -1 && P(2) <= 1
		break
	else
		fprintf('Invalid input, please try again \n');
	end
end

%set x1 and x2
x1  = P(1);
x2  = P(2);

%surface function to be minimised
f   =@(x1,x2)   (x2-x1).^4 + 8.*x1.*x2 - x1 + x2 + 3;
%function surface gradient
gradf   =@(x1,x2)   [   -4.*(x2-x1).^3 + 8.*x2 - 1; 4.*(x2-x1).^3 + 8.*x1 + 1];
%Hessian Matrix
hessf =@(x1,x2)     [   12.*(x2-x1).^2,        -12.*(x2-x1).^2 + 8;
                       -12.*(x2-x1).^2 + 8,     12.*(x2-x1).^2      ];
%Generate first minimum
E = f(x1,x2);

%Loop emergency brake
itter = 0;

%Minimise loop
while E(end) > 0 && itter < 100
    delta   = -inv(hessf(x1(end),x2(end)))*gradf(x1(end),x2(end));
    x1      = [ x1  x1(end) + delta(1)];
    x2      = [ x2  x2(end) + delta(2)];
    E       = [ E   f(x1(end),x2(end))];
    itter   = itter + 1;
end

%plot contour
hold on
[x, y]   = meshgrid(-1:.01:1);
contour(x,y,f(x,y),40);
plot(x1,x2,'r');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%