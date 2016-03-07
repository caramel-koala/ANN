%weighting
W = [1,1];

%bias
b = -1.1;

p = [.6 .9 .3 .9 .4 1 ;
     .1 .2 .2 .9 .8 .9 ];

n = W*p + b

a = hardlim(n)