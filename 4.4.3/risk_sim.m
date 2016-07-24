%risk_sim.m
%finds the risk factor for a specific person
%Author: Antonio Peters

x = [0.6 0.8 0.5 0.1]';

y = risknet(x);

fprintf('Risk for this person: %f\n',y)