function [P,T] = getPT(pr,tr)

while true
	%pattern
	P	= input('Pattern:');
	if size(P) == 0
		P 	= ones(pr,1);
	end
	[vals(1), vals(2)] = size(P);
	
	%target
	T	= input('Target:');
	if size(T) == 0
		T 	= ones(pr,1);
	end
	[vals(3), vals(4)] = size(T);
				
	if vals(1)==pr && vals(3)==tr && vals(2)==vals(4);
		break
	else
		fprintf('Invalid input, please try again \n');
	end
end
end