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
theta0 = theta_star(0)*omega(0) + d(0);

% ode45 options
opt = odeset('RelTol', 1E-5, 'AbsTol',1E-6);

figure
hold on
% Estimator gain
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0, opt);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])

end

yline(theta_star(0), 'DisplayName','True')

title("w(t) = sin(t) d(t) = 0")
hold off
legend(Location="southeast")

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Estimator gain

figure
hold on
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])


end
yline(theta_star(0), 'DisplayName','True')
title("w(t) = sin(t) d(t) = 0.5*sin(20*t)")
hold off
legend(Location="southeast")

%% Part 2
clear; clc; close all;

% Used for ode45
tspan = [0, 50];
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
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0, opt);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])

end

plot(sol.x, theta_star(sol.x), 'k', 'DisplayName','True')

title("w(t) = sin(t) d(t) = 0")
hold off
legend(Location="southeast")

% disturbance signal
d = @(t) 0.5*sin(20*t);

% Initial condition
theta0 = theta_star(0)*omega(0) + d(0);

% Estimator gain

figure
hold on
for g = [0.1, 1, 5]

% Creating function to be estimated
estimator = @(t, theta) gradient_estimator(t, theta, omega(t), d(t), theta_star(t), g);

sol = ode45(estimator, tspan, theta0);


plot(sol.x, sol.y, 'DisplayName',['g = ', num2str(g)])


end
plot(sol.x, theta_star(sol.x), 'k', 'DisplayName','True')
title("w(t) = sin(t) d(t) = 0.5*sin(20*t)")
hold off
legend(Location="southeast")

%% Part 3
clear; clc; close all;

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

estimator = @(t, x) recursive_ls(t, x, omega(t), 0, theta_star(t) * omega(t) + d(t));

figure 
hold on
for P0 = [2, 10]
    sol = ode45(estimator, tspan, [theta0; P0], opt);
    plot(sol.x, sol.y(1, :), 'DisplayName',['P0 = ', num2str(P0)])
end

yline(theta_star(sol.x), 'k', 'DisplayName','True')
hold off
title('Least Squares w(t) = sin(t) d(t) = 0')
legend('Location','east')


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
title('Least Squares w(t) = sin(t) d(t) = 0.5sin(20t)')
legend('Location','east')