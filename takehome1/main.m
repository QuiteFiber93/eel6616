%% Part 1
clear; clc; close all;

% Used for ode45
tspan = [0, 50];

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = 0;

% Estimator gain

figure
hold on
for g = logspace(-1, 0, 3)

% Creating function to be estimated
estimator = @(t, theta) estimate_dynamics(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])

end

for g = logspace(-1, 0, 3)*5

% Creating function to be estimated
estimator = @(t, theta) estimate_dynamics(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])

end

hold off
legend(Location="southeast")