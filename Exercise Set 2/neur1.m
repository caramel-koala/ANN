%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neur1.m
%weight updating, single node, neural perceptron
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pattern
P	= [	1	-1	0;
	 	2 	2	-1;
	 	1	1	1]; 
 
%target
T	= [	1	0	0];

%random inital weighting
W	= rand(1,3)


%calculate activation
A = hardlim(W*P)

%calculate error
E = T - A

%loop halting variable
halt = 0;

while sum(E.^2) ~= 0 | halt == 50
	%update
	W = W + E * P'
	
	A = hardlim(W*P)

	E = T - A

	halt = halt + 1;
end

x = linspace(-2,2,100);

y = -(W(1)*x + W(3))/W(2);

plot(P(1,:),P(2,:),'o',x,y)