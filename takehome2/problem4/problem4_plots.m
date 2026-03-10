clear; clc; close all;

% Loading Model to run
modelname = 'problem4';
load_system(modelname);

% Model parameters
alpha_param = [1.847E-4; 1.922E-4];
beta_param = [0.8869; -1.8850];
theta_star = [alpha_param; -beta_param]';
ff_vals = [1, 0.97];

% Part (a)
% Changing model stop time to 1000 time steps
set_param(modelname, 'StopTime', '1000');

% Plotting ln(|err|) on y-axis
figure

hold on
for n = 0:1
    set_param([modelname, '/RLS w FF/FF Switch'], 'sw', num2str(n))
    % Looping through model for different FF to compare
    out = sim(modelname);
    theta_estimate = out.logsout.get('theta_rls').Values;
    err = theta_estimate.Data - theta_star;
    lambda = ff_vals(n + 1);
    stairs(theta_estimate.Time, log(vecnorm(err, 2, 2).^2), ...
        'DisplayName', ['\lambda =', num2str(lambda)])
    
    theta_estimate.Data(end, :)
    err(end, :)
end
hold off

grid
legend
xlabel('Time Step')
ylabel('log(||\theta*(k) - \theta(k)||^2)')
title('RLS Parameter Estimation Error Norm for Varied \lambda')

saveas(gca, 'rls_p4.png', 'png')

% Part (b)
% Next part of problem wants 4000 time steps
set_param(modelname, 'StopTime', '4000');

% Running Model but this time we only care about the gradient estimator
out = sim(modelname);
theta_estimate = out.logsout.get('theta_grad').Values;
err = theta_estimate.Data - theta_star;

% Plotting ln|err| for gradient estimator
figure
t = tiledlayout(2, 1,'TileSpacing','tight','Padding','none');
nexttile;

stairs(theta_estimate.Time, log(vecnorm(err, 2, 2).^2), ...
    'DisplayName', ['\lambda =', num2str(lambda)])

grid
xlabel('Time Step')
ylabel('log(||\theta*(k) - \theta(k)||^2)')
ylim([1.3, 1.5])
title('All Time Steps')

nexttile;

stairs(theta_estimate.Time(end-999:end, :), log(vecnorm(err(end-999:end, :), 2, 2).^2), ...
    'DisplayName', ['\lambda =', num2str(lambda)])

grid
xlabel('Time Step')
ylabel('log(||\theta*(k) - \theta(k)||^2)')
title('Last 1000 Time Steps')
title(t, "Normalized Gradient Parameter Estimation Error Norm")

exportgraphics(t, 'grad_estiamte_logerr_p4.png', 'Resolution', 300)

% Plotting two values, alpha_1 and beta_1 arbitrarily chosen
figure
t = tiledlayout(2, 1,'TileSpacing','tight','Padding','none');
nexttile;

stairs(theta_estimate.Time, theta_estimate.Data(:, 1), ...
    'DisplayName', '\alpha_1 Estimate')
yline(theta_star(1), '--', 'DisplayName', '\alpha_1 True')

legend
grid
ylabel('\alpha_1')
xlabel('Time Step')

nexttile;

stairs(theta_estimate.Time, -theta_estimate.Data(:, 3), ...
    'DisplayName', '\beta_1 Estimate')
yline(-theta_star(3), '--', 'DisplayName', '\beta_1 True')

legend
grid
ylabel('\beta_1')
xlabel('Time Step')
title(t, 'Selected Parameter Estimates')

exportgraphics(t, 'grad_estimate_param_p4.png', 'Resolution', 300)