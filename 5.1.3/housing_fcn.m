%housing_fcn.m
%simulates new data on housing.mat
%Author: Antonio Peters
%Modefied from schoolnet.m

function y = housing_fcn(x)

load housingnet.mat

if size(x,1)~=r
    error('x incorrect size');
end

y=sim(housingnet,x);

end