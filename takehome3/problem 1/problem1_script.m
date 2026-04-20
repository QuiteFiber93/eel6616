clear; clc; close all;

% Run problem1.slx
load_system("problem1.slx")
set_param('problem1/MPC/sigma', 'Gain', '0.01');
simOut = sim('problem1');

y_m = simOut.logsout.get('y_m').Values;
y_p = simOut.logsout.get('y_p').Values;
u = simOut.logsout.get('u').Values;
b_hat = simOut.logsout.get('b_hat').Values;
a_hat = simOut.logsout.get('a_hat').Values;

% Plot y_m and y_p vs t
figure;
subplot(2,1,1);
hold on
stairs(y_m.Time, y_m.Data, 'b');
stairs(y_p.Time, y_p.Data, 'r');
hold off
xlabel('Time steps');
ylabel('Output');
legend('y_m (Model)', 'y_p (Plant)');
title('Model vs Plant Output');
grid on;

subplot(2,1,2);
stairs(y_m.Time, y_m.Data - y_p.Data, 'b');
xlabel('Time steps');
ylabel('Output Error');
title('Model vs Plant Output');
grid on;

exportgraphics(gcf, 'output_sigma001.png', 'Resolution', 150);

% Plot u vs t
figure;
stairs(u.Time, u.Data, 'k');
xlabel('Time steps');
ylabel('u');
title('Control Input');
grid on;

exportgraphics(gcf, 'u_sigma001.png');

% Plot b and a estimates
figure;
subplot(2,1,1);
stairs(b_hat.Time, b_hat.Data, 'b', 'DisplayName', '$\hat{b}$');
yline(0.0952, '--k', 'DisplayName', 'True b')
xlabel('Time steps');
ylabel('$\hat{b}$', 'Interpreter', 'latex');
title('$\hat{b}$ Estimate', 'Interpreter', 'latex');
legend('Location','east')
grid on;

subplot(2,1,2);
stairs(a_hat.Time, a_hat.Data, 'r', 'DisplayName', '$\hat{a}$');
yline(0.9048, '--k', 'DisplayName', 'True a')
xlabel('Time steps');
ylabel('$\hat{a}$', 'Interpreter', 'latex');
legend('Location','east')
title('$\hat{a}$ Estimate', 'Interpreter', 'latex');
grid on;

exportgraphics(gcf, 'param_sigma001.png');


% Rerunning sim with sigma = 1
set_param('problem1/MPC/sigma', 'Gain', '1');
simOut = sim('problem1');

y_m = simOut.logsout.get('y_m').Values;
y_p = simOut.logsout.get('y_p').Values;
u = simOut.logsout.get('u').Values;
b_hat = simOut.logsout.get('b_hat').Values;
a_hat = simOut.logsout.get('a_hat').Values;

% Plot y_m and y_p vs t
figure;
subplot(2,1,1);
hold on
stairs(y_m.Time, y_m.Data, 'b');
stairs(y_p.Time, y_p.Data, 'r');
hold off
xlabel('Time steps');
ylabel('Output');
legend('y_m (Model)', 'y_p (Plant)');
title('Model vs Plant Output (\sigma=1)');
grid on;


subplot(2,1,2);
stairs(y_m.Time, y_m.Data - y_p.Data, 'b');
xlabel('Time steps');
ylabel('Output Error');
title('Model vs Plant Output (\sigma = 1)');
grid on;

exportgraphics(gcf, 'output_sigma100.png');

% Plot u vs t
figure;
stairs(u.Time, u.Data, 'k');
xlabel('Time steps');
ylabel('u');
title('Control Input (\sigma = 1)');
grid on;

exportgraphics(gcf, 'u_sigma100.png');
% Plot b and a estimates
figure;
subplot(2,1,1);
stairs(b_hat.Time, b_hat.Data, 'b', 'DisplayName', '$\hat{b}$');
yline(0.0952, '--k', 'DisplayName', 'True b')
xlabel('Time steps');
ylabel('$\hat{b}$', 'Interpreter', 'latex');
title('$\hat{b}$ Estimate $(\sigma = 1)$', 'Interpreter', 'latex');
legend('Location','east')
grid on;

subplot(2,1,2);
stairs(a_hat.Time, a_hat.Data, 'r', 'DisplayName', '$\hat{a}$');
yline(0.9048, '--k', 'DisplayName', 'True a')
xlabel('Time steps');
ylabel('$\hat{a}$', 'Interpreter', 'latex');
legend('Location','east')
title('$\hat{a}$ Estimate $(\sigma = 1)$', 'Interpreter', 'latex');
grid on;

exportgraphics(gcf, 'param_sigma100.png');