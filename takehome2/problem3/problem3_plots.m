clear; clc; close all;


% Used to run the simulink model multiple times with different parameters
modelname = 'problem3';
mdlWks = get_param(modelname, 'ModelWorkspace');

% Parameter values to be compared against
alpha_1_param = 0.0952;
beta_1_param = -0.9048;
theta_star = [alpha_1_param, beta_1_param];

% Plots for lambda = 1
% Assigns values for lambda and P0
assignin(mdlWks, 'lambda', 1)
assignin(mdlWks, 'P0', 100*eye(2))

% Runs simulation for given parameters
out = sim(modelname);

% Extracting simulation results
theta_estimate = out.logsout.get('theta').Values;
y = out.logsout.get('y').Values;

% Plotting the results
figure

hold on
stairs(theta_estimate.Time, theta_estimate.Data(:, 1), ...
    'DisplayName', '\alpha_1 Estimate');
stairs(theta_estimate.Time, theta_estimate.Data(:, 2), ...
    'DisplayName', '\beta_1 Estimate');
hold off

% True values
yline(alpha_1_param, '--b', 'DisplayName','\alpha*_1')
yline(beta_1_param, '--r', 'DisplayName','\beta*_1')

xlabel('Time Steps')
ylabel('Estimate')
ylim([-1, 0.2])
title('Parameter Estimates');

legend('Location','east')
grid


saveas(gca, 'parameter_estimates_p3.png', 'png')
figure
stairs(y.Time, y.Data, 'DisplayName', 'y')

xlabel('Time Steps')
ylabel('Output')
ylim([0, 1.1])
title('y(k)')
grid

saveas(gca, 'yk_p3.png', 'png')

figure
t = tiledlayout(2, 1,'TileSpacing','tight','Padding','none');
title(t, 'Parameter Estimate Error for Varied P(0)')
nexttile;

% Looping through different values of P0
% Assigning Model Workspace P0 to these values and running simulation
% Extracting theta estimates and finding error
% Then plotting

hold on
for coeff = [100, 1000, 10000]
    assignin(mdlWks, 'P0', coeff*eye(2))
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
ylim([-25, 0])

nexttile;
% Assinging forgetting factor to 0.9
assignin(mdlWks, 'lambda', 0.9)

% Looping through different values of P0
% Assigning Model Workspace P0 to these values and running simulation
% Extracting theta estimates and finding error
% Then plotting

hold on
for coeff = [100, 1000, 10000]
    assignin(mdlWks, 'P0', coeff*eye(2))
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
ylim([-25, 0])

exportgraphics(t, 'forgetting_factor_p3.png', 'Resolution', 300)