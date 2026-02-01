clear; clc; 
gradientEstimator = "gradient_estimator";
open_system(gradientEstimator)

gains = [0.1, 0.5, 1, 5];
results = cell(1, length(gains));
figure(1)
hold on
for n = 1:length(gains)
    % set_param([gradientEstimator ".slx/-g"], '-g', num2str(-gains(n)));
    results{n} = sim(gradientEstimator);
    plot(results{n}.tout, results{n}.yout)
end

hold off