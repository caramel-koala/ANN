function [P,T, pr] = getPT(pc,tc)

while true
	%pattern
	P	= input('Pattern:');
	if size(P) == 0
		P 	= ones(pc,1);
	end
	[vals(1), vals(2)] = size(P);
	
	%target
	T	= input('Target:');
	if size(T) == 0
		T 	= ones(pc,1);
	end
	[vals(3), vals(4)] = size(T);
				
	if vals(1)==pc && vals(3)==tc && vals(2)==vals(4);
        pr = vals(2);
		break
	else
		fprintf('Invalid input, please try again \n');
	end
end
end