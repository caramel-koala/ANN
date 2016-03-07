function b=quadreg(x,y)

A = zeros(3);
C = zeros(3,1);

for i=1:length(x)
	%Set A
    A(1,1) = A(1,1) + x(i)^4;
	
    A(1,2) = A(1,2) + x(i)^3;
    A(2,1) = A(1,2);
    
	A(1,3) = A(1,3) + x(i)^2;
    A(2,2) = A(1,3);
    A(3,1) = A(1,3);
    
    A(2,3) = A(2,3) + x(i);
    A(3,2) = A(2,3);
    
    A(3,3) = A(3,3) + 1;
    
    %Set C
    C(1) = C(1) + x(i)^2*y(i);
    C(2) = C(2) + x(i)*y(i);
    C(3) = C(3) + y(i);
    
end

b = A\C;