clear; clc; close all;

modelname = 'problem3';

alpha_1 = 0.0952;
beta_1 = -0.9048;
theta_star = [alpha_1; beta1];
theta0 = zeros(2, 1);
P0 = 1000 * eye(2);

% Plots for lambda = 1
lambda = 1;

out = sim(modelname);

theta_ts = out.logsout.get('theta').Values;
y_ts = out.logsout.get('y').Values;

% Plotting the results
figure;
hold on
plot(theta_ts.Time, squeeze(theta_ts.Data));
plot(y_ts.Time, squeeze(y_ts.Data))
grid on;
legend('\alpha_1 (Estimate)', '\beta_1 (Estimate)', 'y(k)');
title('Recursive Least Squares Parameter Convergence');
xlabel('Time Steps');
legend('Location','best')
hold off

for lambda = [0.9, 1]
    for coeff = [100, 1000, 10000]
    end
end