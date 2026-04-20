clear; clc; close all;

% sim problem3.slx
simOut = sim('problem3.slx');

y_m = simOut.logsout.get('y_m').Values;
y_p = simOut.logsout.get('y_p').Values;
u = simOut.logsout.get('u').Values;
b_hat = simOut.logsout.get('b_hat').Values;
a_hat = simOut.logsout.get('a_hat').Values;
c0 = simOut.logsout.get('c0').Values;
d0 = simOut.logsout.get('d0').Values;

% Plot y_m and y_p vs t
figure;
hold on
stairs(y_m.Time, y_m.Data, 'b');
stairs(y_p.Time, y_p.Data, 'r');
hold off
xlabel('Time steps');
ylabel('Output');
legend('y_m (Model)', 'y_p (Plant)');
title('Model vs Plant Output');
grid on;

exportgraphics(gcf, 'output.png', 'Resolution', 300);

% Plot u vs t
figure;
stairs(u.Time, u.Data, 'k');
xlabel('Time steps');
ylabel('u');
title('Control Input');
grid on;

exportgraphics(gcf, 'u.png', 'Resolution', 300);

% Plot b and a estimates
figure;
subplot(2,1,1);
stairs(b_hat.Time, b_hat.Data, 'b', 'DisplayName', '$\hat{b}$');
yline(0.0952, '--k', 'DisplayName', 'True b')
xlabel('Time steps');
ylabel('$\hat{b}$', 'Interpreter', 'latex');
title('$\hat{b}$ Estimate', 'Interpreter', 'latex');
legend('Location','east', 'Interpreter','latex')
grid on;

subplot(2,1,2);
stairs(a_hat.Time, a_hat.Data, 'r', 'DisplayName', '$\hat{a}$');
yline(0.9048, '--k', 'DisplayName', 'True a')
xlabel('Time steps');
ylabel('$\hat{a}$', 'Interpreter', 'latex');
legend('Location','east', 'Interpreter','latex')
title('$\hat{a}$ Estimate', 'Interpreter', 'latex');
grid on;

exportgraphics(gcf, 'param.png', 'Resolution', 300);

% Plot controller parameters
figure;
subplot(2,1,1);
stairs(c0.Time, c0.Data, 'b', 'DisplayName', 'c_0');
yline(2.7227, '--k', 'DisplayName', 'Nominal')
xlabel('Time steps');
ylabel('c_0');
title('c_0 Over Time');
legend('Location','east')
grid on;

subplot(2,1,2);
stairs(d0.Time, d0.Data, 'r', 'DisplayName', 'd_0');
yline(-1.7227, '--k', 'DisplayName', 'Nominal')
xlabel('Time steps');
ylabel('d_0');
title('d_0 Over Time');
legend('Location','east')
grid on;

exportgraphics(gcf, 'controller.png', 'Resolution', 300);