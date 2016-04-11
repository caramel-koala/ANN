%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%backprop1.m
%Uses the back propagation method on a (3,2,2) NN
%AUTHOR: Antonio Peters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plen    = 3;%length of pattern vector
tlen    = 2;%length of target vector
[P, T, pr]  = getPT(plen,tlen); %get pattern and target from user

alpha   = 0.1; %the learning rate

W1  = rand(2,plen);   %generate first weight matrix
W2  = rand(tlen,2); %generate second weight matrix
b1  = rand(1,1);    %generate first bias
b2  = rand(1,1);    %generate second bias

a1  = tansig(W1*P + b1); %activate first layer with tansig
a2  = logsig(W2*a1 + b2);%activate second layer with logsig

%diagonal matrices
D2  =@(x) [ (1 - x(1,:)).*x(1,:),   0;
            0,                      (1 - x(2,:)).*x(2,:)];
D1  =@(x) [ (1 - x(1,:).^2),    0;
            0,                  (1 - x(2,:).^2)]; 
    
%calculate error
E   = sum(sum((T-a2).^2));

count = 0;
while E(end) > 0.001 && count < 100
    %sensitvity
    sigma2  = -2*D2(a2)*(T-a2);
    sigma1  = D1(a1)*(W2)'*sigma2;

    %update weight and biases
    W2  = W2 - alpha*sigma2*a1';
    b2  = b2 - alpha*sigma2;
    W1  = W1 - alpha*sigma1*P';
    b1  = b1 - alpha*sigma1;
    
    %reactivate
    a1  = tansig(W1*P + b1);
    a2  = logsig(W2*a1 + b2);
    
    %recalculate error
    E   = [E, sum(sum((T-a2).^2))];
    
    %update counter
    count = count + 1;
end

%plot change in error
plot(1:count+1,E,'r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%