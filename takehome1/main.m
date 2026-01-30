%% Part 1
clear; clc;

% Used for ode45
tspan = [0, 50];

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Estimator gain
g = 1;

% Initial condition
theta0 = 0;

% Creating function to be estimated
estimator = @(t, theta) estimate_dynamics(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);

sol.y(end);