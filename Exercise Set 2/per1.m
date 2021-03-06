%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%per1.m
%weight updating, multiple nodes, neural perceptron
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
		P 	= [	1   1   2   3;
                1   1   1   2;
                1   2   2   4];
	end
	[vals(1), vals(2)] = size(P);
	
	%target
	T	= input('Target:');
	if size(T) == 0
		T 	= [ 1   1   0   1;
                1   1   1   0];
	end
	[vals(3), vals(4)] = size(T);
				
	if vals(2)==vals(4);
		break
	else
		fprintf('Invalid input, please try again \n');
	end
end

P = [P;ones(1,vals(2))];

%random inital weighting
W	= rand(vals(3),vals(1)+1);


%calculate activation
A = hardlim(W*P);

%calculate error
E = T - A;
E2 = sum(sum(E.^2));

%loop halting variable
halt = 0;
maxitter = 100;

while sum(sum(E.^2)) ~= 0 && halt < maxitter
	%update
	W = W + E * P';
	
	A = hardlim(W*P);

	E = T - A;
    
    E2 = [E2, sum(sum(E.^2))];

	halt = halt + 1;
end

%plot error
plot(0:halt,E2);

if halt == maxitter
	fprintf('Data set is not linearly separable within %d itterations.\n', maxitter);
	return;
else
    fprintf('Number of itterations: %d \n',halt);
end


while true
	%request input
	yn	= input('Clasify another point? Yes = 1, No = 0 (default = No):');

	%check result
	if size(yn) == 0
		%exit loop
		break;
    elseif yn == 1
		%get new pattern
		Pnew	= input('Pattern:');
        if size(Pnew) ~= vals(1);
           fprintf('Invalid Pattern \n');
           continue;
        end
		Pnew	= [Pnew 1];
		%Classify new point
		a = hardlim(W*Pnew')
	else 
		%exit loop
		break;
	end
	
end