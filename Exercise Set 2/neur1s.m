%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neur1s.m
%weight updating, single node, neural perceptron using sequential training
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%values of matrix sizes
vals = zeros(1,4);
while true
	%pattern
	P	= input('Pattern:');
	if size(P) == 0
		P 	= [	1 1 -1 -2 -1;
				2 -2 -1 0 2];
	end
	[vals(1), vals(2)] = size(P);
	
	%target
	T	= input('Target:');
	if size(T) == 0
		T 	= [1 1 0 0 0];
	end
	[vals(3), vals(4)] = size(T);
				
	if vals(1)==2 && vals(3)==1 && vals(2)==vals(4);
		break
	else
		fprintf('Invalid input, please try again \n');
	end
end

P = [P;ones(1,vals(2))];

%random inital weighting
W	= rand(1,3);


%calculate activation
A = hardlim(W*P);

%calculate error
E = T - A;

%loop halting variable
halt = 0;
maxitter = 100;

while sum(E.^2) ~= 0 && halt < maxitter
	%update
    
    i = mod(halt,vals(2)) + 1;
    
    a = hardlim(W*P(:,i));
    
    e = T(i) - a;
    
	W = W + e * P(:,i)';
	
	A = hardlim(W*P);

	E = T - A;

	halt = halt + 1;
end

if halt == maxitter
	fprintf('Data set is not linearly separable within %d itterations.\n', maxitter);
	return;
end

x = linspace(-5,5,100);

y = -(W(1)*x + W(3))/W(2);

hold on;

for i=1:vals(2)
	if T(i) == 1
		plot(P(1,i),P(2,i),'o');
	else
		plot(P(1,i),P(2,i),'x');
	end
end

plot(x,y,'r');

while true
	%request input
	yn	= input('Clasify another point? Yes = 1, No = 0 (default = No):');

	%check result
	if size(yn) == 0 || yn == 0
		%exit loop and stop plotting
		hold off;
		break;
    elseif yn == 1
		%get new pattern
		Pnew	= input('Pattern:');
        if size(Pnew) ~= 2
           fprintf('Invalid Pattern \n');
           continue;
        end
		Pnew	= [Pnew 1];
		%process new point
		Anew = hardlim(W*Pnew');
		%plot new point
		if Anew == 1
			plot(Pnew(1),Pnew(2),'o');
		else
			plot(Pnew(1),Pnew(2),'x');
		end
	else 
		%exit loop and stop plotting
		hold off;
		break;
	end
	
end