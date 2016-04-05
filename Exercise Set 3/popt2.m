%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3.8.3 [1]
% popt2.m
% Descends to the minimum of a function from a given starting point.
%Author: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Get starting point
while true
	P	= input('Starting Points:');
	if length(P) ~= 2
		P 	= [	.8,  -.25];
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
f   =@(x1,x2)   x1.^2 + x1.*x2 + x2.^2;

%gradient function
gradf   =@(x1,x2)   [ 2*x1 + x2,  x1 + 2*x2];

%Hessian Matrix
hessf   =   [   2,  1;
                1,  2];
%search direction
vf  =@(x1,x2)  -gradf(x1,x2)'; 
            
%direction distance
alphaf  =@(x1,x2)   -(gradf(x1,x2)*vf(x1,x2))/(vf(x1,x2)'*hessf*vf(x1,x2));

%generate error
E = f(x1, x2);

itter = 0; %loop emergency break
while   E(end) > 0 && itter < 100
    delta   = alphaf(x1(end),x2(end))*vf(x1(end),x2(end));
    x1  = [ x1, x1(end)+delta(1)]; 
    x2  = [ x2, x2(end)+delta(2)]; 
    E   = [ E   f(x1(end),x2(end))];
    itter   = itter + 1;
end

%plot contour
hold on
[x, y]   = meshgrid(-1:.01:1);
contour(x,y,f(x,y),40);
plot(x1,x2,'r');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%