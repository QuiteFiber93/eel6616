clear; clc;
lsEstimator = 'ls_estimator';

P0s = [2, 10];
lambdas = [0, 0.5, 1.5];

Simulink.sdi.clear;

for m = 1:length(P0s)
P0 = P0s(m);
    for n = 1:length(lambdas)
        close_system(lsEstimator, 0);
        load_system(lsEstimator);
        set_param('ls_estimator/lambda', 'Value', num2str(lambdas(n)));
        set_param('ls_estimator/theta', 'SignalName', ['P0 = ', num2str(P0), ', lambda = ', num2str(lambdas(n))]);
        set_param('ls_estimator/true', 'SignalName', 'True');
        simOut = sim(lsEstimator);
    end
end

Simulink.sdi.view;