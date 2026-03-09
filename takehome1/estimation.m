%% Part 1
clear; clc; close all;
% =====================================================
% GRADIENT ESTIMATOR WITH CONSTANT M AND NO DISTURBANCE
%======================================================

% Used for ode45
tspan = 0:0.1:50;

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% ode45 options
opt = odeset('RelTol', 1E-5, 'AbsTol',1E-6);

figure
hold on

% Using various gains in estimator
% rmse_vals collects the rmse for comparison
rmse_vals = [];
g_vals =  [0.1, 1, 5];
for g = g_vals

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

% Integrating over time span
[t, theta] = ode45(estimator, tspan, theta0, opt);

% Plotting integrated values
plot(t, theta, 'DisplayName',['g = ', num2str(g)])

% Calculating rmse for comparion
rmse_vals = [rmse_vals, rmse(theta, theta_star(t))];

end

% True value for visual comparison
yline(theta_star(0), 'DisplayName','True')

xlabel('t')
ylabel('\theta')
title("Gradient Estimator with No Disturbance")
hold off
legend(Location="southeast")

% Printing RMSE values
disp('With d(t) = 0')
disp('=============')
rmse_vals

% =====================================================
% GRADIENT ESTIMATOR WITH CONSTANT M AND DISTURBANCE
%======================================================

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Estimator gain

figure
hold on
rmse_vals = [];
g_vals =  [0.1, 1, 5];
for g = g_vals

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

[t, theta] = ode45(estimator, tspan, theta0, opt);

plot(t, theta, 'DisplayName',['g = ', num2str(g)])

rmse_vals = [rmse_vals, rmse(theta, theta_star(t))];

end
yline(theta_star(0), 'DisplayName','True')
title("Gradient Estimator with Sinusoidal Disturbance")
xlabel('t')
ylabel('\theta')
hold off
legend(Location="southeast")

disp('With d(t) = 0.5sin(20t)')
disp('=============')
rmse_vals

%% Part 2
clear; clc; close all;
% =====================================================
% GRADIENT ESTIMATOR WITH VARIABLE M AND NO DISTURBANCE
%======================================================

% Used for ode45
tspan = 0:0.1:50;
opt = odeset('RelTol', 1E-6, 'AbsTol',1E-7);

% True mass of the system
theta_star = @(t) 1 + 0.5*sin(0.5*t);

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

figure
hold on
rmse_vals = [];
g_vals =  [0.1, 1, 5];

for g = g_vals

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

[t, theta] = ode45(estimator, tspan, theta0, opt);

plot(t, theta, 'DisplayName',['g = ', num2str(g)])

rmse_vals = [rmse_vals, rmse(theta, theta_star(t))];
end

plot(t, theta_star(t), 'k', 'DisplayName','True')

title("Gradient Estimator with No Disturbance")
xlabel('t')
ylabel('\theta')
hold off
legend(Location="southeast")

disp('With d(t) = 0')
disp('=============')
rmse_vals

% =====================================================
% GRADIENT ESTIMATOR WITH VARIABLE M AND DISTURBANCE
%======================================================

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Estimator gain

figure
hold on
rmse_vals = [];
g_vals =  [0.1, 1, 5];
for g = g_vals

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

[t, theta] = ode45(estimator, tspan, theta0, opt);

plot(t, theta, 'DisplayName',['g = ', num2str(g)])

rmse_vals = [rmse_vals, rmse(theta, theta_star(t))];
end
plot(t, theta_star(t), 'k', 'DisplayName','True')
title("Gradient Estimator with Sinusoidal Disturbance")
hold off
legend(Location="southeast")

disp('With d(t) = 0.5sin(20t)')
disp('=============')
rmse_vals

%% Part 3
clear; clc; close all;

% =====================================================
% RECURSIVE LS CONSTANT M WITHOUT DISTURBANCE / FF
%======================================================

% Used for ode45
tspan = 0:0.1:50;
opt = odeset('RelTol', 1E-6, 'AbsTol',1E-7);

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = 0;

% Function to be used in integration
estimator = @(t, x) recursive_ls(t, x, omega(t), 0, theta_star(t) * omega(t) + d(t));

figure 
hold on
for P0 = [2, 10]
    sol = ode45(estimator, tspan, [theta0; P0], opt);
    plot(sol.x, sol.y(1, :), 'DisplayName',['P0 = ', num2str(P0)])
end

% True value for comparison
yline(theta_star(sol.x), 'k', 'DisplayName','True')
hold off
title('Least Squares with no Disturbance or Forgetting')
legend('Location','east')

% =====================================================
% RECURSIVE LS CONSTANT M WITH DISTURBANCE AND NO FF
%======================================================

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = 0;

estimator = @(t, x) recursive_ls(t, x, omega(t), 0, theta_star(t) * omega(t) + d(t));

figure 
hold on
for P0 = [2, 10]
    sol = ode45(estimator, tspan, [theta0; P0], opt);
    plot(sol.x, sol.y(1, :), 'DisplayName',['P0 = ', num2str(P0)])
end

yline(theta_star(sol.x), 'k', 'DisplayName','True')
hold off
title('Least Squares with Disturbance and No Forgetting')
legend('Location','east')

% =====================================================
% RECURSIVE LS CONSTANT M WITH NO DISTURBANCE / FF = 0.5
%======================================================

% Used for ode45
tspan = [0, 50];
opt = odeset('RelTol', 1E-6, 'AbsTol',1E-7);

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = 0;

% Function to be used in integration
ff = 0.5;
estimator = @(t, x) recursive_ls(t, x, omega(t), ff, theta_star(t) * omega(t) + d(t));

figure 
hold on
for P0 = [2, 10]
    sol = ode45(estimator, tspan, [theta0; P0], opt);
    plot(sol.x, sol.y(1, :), 'DisplayName',['P0 = ', num2str(P0)])
end

% True value for comparison
yline(theta_star(sol.x), 'k', 'DisplayName','True')
hold off
title('Least Squares with Fogetting and no Disturbance')
legend('Location','east')

% =====================================================
% RECURSIVE LS CONSTANT M WITH DISTURBANCE AND FF = 0.5
%======================================================

% True mass of the system
theta_star = @(t) 2;

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = 0;

estimator = @(t, x) recursive_ls(t, x, omega(t), ff, theta_star(t) * omega(t) + d(t));

figure 
hold on
for P0 = [2, 10]
    sol = ode45(estimator, tspan, [theta0; P0], opt);
    plot(sol.x, sol.y(1, :), 'DisplayName',['P0 = ', num2str(P0)])
end

yline(theta_star(sol.x), 'k', 'DisplayName','True')
hold off
title('Least Squares with Disturbance and Forgetting')
legend('Location','east')


%% Part 4
clear; clc; close all;

% =====================================================
% RECURSIVE LS VARIABLE M WITHOUT DISTURBANCE / FF
%======================================================

% Used for ode45
tspan = 0:0.1:50;
opt = odeset('RelTol', 1E-6, 'AbsTol',1E-7);

% True mass of the system
theta_star = @(t) 1 + 0.5*sin(0.5*t);

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Function to be passed into ode45
estimator = @(t, x) recursive_ls(t, x, omega(t), 0.0, theta_star(t) * omega(t) + d(t));

figure 
hold on
% Different values of P0 to try
for P0 = [2, 10]

    % Integrates to solve theta and plots
    [t, y] = ode45(estimator, tspan, [theta0; P0], opt);
    plot(t, y(:, 1), 'DisplayName',['P0 = ', num2str(P0)])
end

% Plotting truth
plot(t, theta_star(t), 'k', 'DisplayName','True')
hold off
title('Least Squares with no Disturbance or Forgetting')
xlabel('t')
ylabel('\theta')
legend('Location','east')

% =====================================================
% RECURSIVE LS VARIABLE M WITH DISTURBANCE / no FF
%======================================================
% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Function to be passed into ode45
estimator = @(t, x) recursive_ls(t, x, omega(t), 0.0, theta_star(t) * omega(t) + d(t));

figure 
hold on
% Different values of P0 to try
for P0 = [2, 10]

    % Integrates to solve theta and plots
    [t, y] = ode45(estimator, tspan, [theta0; P0], opt);
    plot(t, y(:, 1), 'DisplayName',['P0 = ', num2str(P0)])
end

% Plotting truth
plot(t, theta_star(t), 'k', 'DisplayName','True')
hold off
title('Least Squares with Disturbance and no Forgetting')
xlabel('t')
ylabel('\theta')
legend('Location','east')

% =====================================================
% RECURSIVE LS VARIABLE M WITHOUT DISTURBANCE / FF = 0.5
%======================================================

% Used for ode45
tspan = [0, 100];
opt = odeset('RelTol', 1E-6, 'AbsTol',1E-7);

% True mass of the system
theta_star = @(t) 1 + 0.5*sin(0.5*t);

% omega signal
omega = @(t) sin(t);

% disturbance signal
d = @(t) 0;

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Function to be passed into ode45
ff = 1.5;
estimator = @(t, x) recursive_ls(t, x, omega(t), ff, theta_star(t) * omega(t) + d(t));

figure 
hold on
% Different values of P0 to try
for P0 = [2, 10]

    % Integrates to solve theta and plots
    [t, y] = ode45(estimator, tspan, [theta0; P0], opt);
    plot(t, y(:, 1), 'DisplayName',['P0 = ', num2str(P0)])
end

% Plotting truth
plot(t, theta_star(t), 'k', 'DisplayName','True')
hold off
title('Least Squares with Forgetting aand no Disturbance')
xlabel('t')
ylabel('\theta')
legend('Location','east')

% =====================================================
% RECURSIVE LS VARIABLE M WITH DISTURBANCE / FF = 0.5
%======================================================
% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Function to be passed into ode45
estimator = @(t, x) recursive_ls(t, x, omega(t), ff, theta_star(t) * omega(t) + d(t));
rmse_vals = [];
figure 
hold on
% Different values of P0 to try
for P0 = [2, 10]

    % Integrates to solve theta and plots
    [t, y] = ode45(estimator, tspan, [theta0; P0], opt);
    rmse_vals = [rmse_vals, rmse(y(:, 1), theta_star(t))];
    plot(t, y(:, 1), 'DisplayName',['P0 = ', num2str(P0)])
end
rmse_vals
% Plotting truth
plot(t, theta_star(t), 'k', 'DisplayName','True')
hold off
title('Least Squares with Disturbance and Forgetting')
xlabel('t')
ylabel('\theta')
legend('Location','east')

%% FUNCTION DEFINITIONS

% This function is used for the parameter estimation in parts 1 and 2
function thetadot = gradient_estimator(t, theta, omega, d, theta_star, g)
 % True signal : u = m_star * w(t) + d(t)
 u = theta_star * omega + d; 
 err = theta * omega - u;
 thetadot = -g * err * omega;
end

% This function is used for the parameter estimation in parts 3 and 4
function ls_estimate_dot = recursive_ls(t, x, omega, lambda, y)
    % unpacking theta and P
    theta = x(1);
    P = x(2);

    % Ensuring P is symmetric
    P = (P + P') / 2;
    
    % Calculating error value
    err = omega' * theta - y;
    
    % Covariance update
    Pdot = lambda * P - P * (omega * omega') * P;

    % State update
    thetadot = -P * omega * err;

    % Exctacting values
    ls_estimate_dot = [thetadot; Pdot];
end