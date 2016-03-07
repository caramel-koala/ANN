%Get Data
p = input('Pattern:');
W = input('Weighting Matrix:');
[s,r] = size(W);
while (length(p) ~= r)
    fprintf('Weighting x length does not match that of Pattern \n');
    W = input('Weighting Matrix:');
    [s,r] = size(W);
end
b = input('Biases:');
while (length(b) ~= s)
    fprintf('Bias length do not match that of Weighting y \n');
    b = input('Biases:');
end
f = input('Transfer Function:');

%Set values for n
n = zeros(s,1);
for i=1:s
    n(i) = W(i,:)*p + b(i);
end

n

%Get a
a = f(n)