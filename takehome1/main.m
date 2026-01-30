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
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])

end

title("w(t) = sin(t) d(t) = 0")
hold off
legend(Location="southeast")

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = 0;

% Estimator gain

figure
hold on
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])


end
title("w(t) = sin(t) d(t) = 0.5*sin(20*t)")
hold off
legend(Location="southeast")

%% Part 2
clear; clc; close all;

% Used for ode45
tspan = [0, 50];

% True mass of the system
theta_star = @(t) 1 + 0.5*sin(0.5*t);

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = 0;

% Estimator gain

figure
hold on
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])

end

title("w(t) = sin(t) d(t) = 0")
hold off
legend(Location="southeast")

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = 0;

% Estimator gain

figure
hold on
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])


end
title("w(t) = sin(t) d(t) = 0.5*sin(20*t)")
hold off
legend(Location="southeast")