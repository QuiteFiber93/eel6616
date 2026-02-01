clear; clc;
gradientEstimator = "gradient_estimator";
gains = [0.1, 0.5, 1, 5];

for n = 1:length(gains)
    close_system(gradientEstimator, 0);
    load_system(gradientEstimator);
    set_param('gradient_estimator/g', 'Gain', num2str(-gains(n)));
    set_param('gradient_estimator/theta', 'SignalName', ['g = ', num2str(gains(n))]);
    simOut = sim(gradientEstimator);
end