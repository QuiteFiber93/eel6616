clear; clc; close all;

modelname = 'problem3';

alpha_1 = 0.0952;
beta_1 = -0.9048;
theta_star = [alpha_1, beta_1];
theta0 = zeros(2, 1);
P0 = 1000 * eye(2);

% Plots for lambda = 1
lambda = 1;

out = sim(modelname);

theta_estimate = out.logsout.get('theta').Values;
y = out.logsout.get('y').Values;

% Plotting the results
figure
t = tiledlayout(2, 1,'TileSpacing','tight','Padding','none');
nexttile;

hold on
stairs(theta_estimate.Time, theta_estimate.Data(:, 1), ...
    'DisplayName', '\alpha_1 Estimate');
stairs(theta_estimate.Time, theta_estimate.Data(:, 2), ...
    'DisplayName', '\beta_1 Estimate');
hold off

% True values
yline(alpha_1, '--b', 'DisplayName','\alpha*_1')
yline(beta_1, '--r', 'DisplayName','\beta*_1')

xlabel('Time Steps')
ylabel('Estimate')
ylim([-1, 0.2])
title('Parameter Estimates');

legend('Location','east')
grid

nexttile;
stairs(y.Time, y.Data, 'DisplayName', 'y')

xlabel('Time Steps')
ylabel('Output')
ylim([0, 1.1])
title('y(k)')
grid

figure
t = tiledlayout(2, 1,'TileSpacing','tight','Padding','none');
title(t, 'Parameter Estimate Error for Varied P(0)')
nexttile;

hold on
for coeff = [100, 1000, 10000]
    P0 = coeff * eye(2);
    out = sim(modelname);
    theta_estimate = out.logsout.get('theta').Values;
    err = theta_estimate.Data - theta_star;
    stairs(theta_estimate.Time, log(vecnorm(err, 2, 2).^2), ...
        'DisplayName', ['P(0) = ', num2str(coeff), '\itI\rm'])
end
hold off

set(gca, 'xtick', 0:25:100)
grid
legend
title('\lambda = 1')

xlabel('Time Step')
ylabel('log(||\theta*(k) - \theta(k)||^2)')

nexttile;
lambda = 0.9;

hold on
for coeff = [100, 1000, 10000]
    P0 = coeff * eye(2);
    out = sim(modelname);
    theta_estimate = out.logsout.get('theta').Values;
    err = theta_estimate.Data - theta_star;
    stairs(theta_estimate.Time, log(vecnorm(err, 2, 2).^2), ...
        'DisplayName', ['P(0) = ', num2str(coeff), '\itI\rm'])
end
hold off

set(gca, 'xtick', 0:25:100)
grid
legend
title('\lambda = 0.9')

xlabel('Time Step')
ylabel('log(||\theta*(k) - \theta(k)||^2)')