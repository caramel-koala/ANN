%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Exercise 4.4.3 1
%Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y   = [7.1    10.3  12.5    16.5    18.7    22.5    24.5    28.3    31.6    34.6]';
t   = 1:1:10;
T   = [t'   ones(length(t),1)];
    
C   = T\Y

f = C(1)*t + C(2);

plot(t,Y,'*',t,f,'b');