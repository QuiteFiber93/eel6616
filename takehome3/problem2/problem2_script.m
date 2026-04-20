clear; clc; close all;

% setting up for part (a)
np = [1 1];
dp= [1 0 1];
load_system('problem2');

% nominal values of parameters for (a)
c0star = 1;
cstar = 2;
d0star = -6;
dstar = 14;

set_param('problem2/P(s)', 'Numerator', mat2str(np));
set_param('problem2/P(s)', 'Denominator', mat2str(dp));

out = sim('problem2.slx');

% plot error
figure;
plot(out.logsout.get('err').Values);
title('Error Signal');
xlabel('Time Step');
ylabel('Error');
grid on;
exportgraphics(gcf, 'output_err_a.png', 'ContentType', 'image', 'Resolution', 300);

% plot parameters c0, c, d, d0
theta = out.logsout.get('theta').Values.Data;
c0 = theta(:,1);
c  = theta(:,2);
d  = theta(:,3);
d0 = theta(:,4);

figure('Position', [100, 100, 800, 900]);
t = tiledlayout(4, 1, 'TileSpacing', 'compact', 'Padding', 'compact');

nexttile;
plot(out.tout, c0, 'DisplayName', 'c_0');
yline(c0star, '--k', 'DisplayName', 'c_0^*')
title('c_0');
xlabel('Time Step');
legend;
grid on;


nexttile;
plot(out.tout, c, 'DisplayName', 'c');
yline(cstar, '--k', 'DisplayName', 'c^*')
title('c');
xlabel('Time Step');
legend;
grid on;

nexttile;
plot(out.tout, d0, 'DisplayName', 'd_0');
yline(d0star, '--k', 'DisplayName', 'd_0^*')
title('d_0');
xlabel('Time Step');
legend;
grid on;

nexttile;
plot(out.tout, d, 'DisplayName', 'd');
yline(dstar, '--k', 'DisplayName', 'd^*')
title('d');
xlabel('Time Step');
legend;
grid on;

title(t, 'Adaptive Parameters');

exportgraphics(gcf, 'param_a.png', 'ContentType', 'image', 'Resolution', 300);

% setting up for part (b)
np = [1 3];
dp= [1 -2 1];

% nominal values of parameters for (a)
c0star = 1;
cstar = 0;
d0star = -8;
dstar = 20;

set_param('problem2/P(s)', 'Numerator', mat2str(np));
set_param('problem2/P(s)', 'Denominator', mat2str(dp));

out = sim('problem2.slx');

% plot error
figure;
plot(out.logsout.get('err').Values);
title('Error Signal');
xlabel('Time Step');
ylabel('Error');
grid on;

exportgraphics(gcf, 'output_err_b.png', 'ContentType', 'image', 'Resolution', 300);

% plot parameters c0, c, d, d0
theta = out.logsout.get('theta').Values.Data;
c0 = theta(:,1);
c  = theta(:,2);
d  = theta(:,3);
d0 = theta(:,4);

figure('Position', [100, 100, 800, 900]);
t = tiledlayout(4, 1, 'TileSpacing', 'compact', 'Padding', 'compact');

nexttile;
plot(out.tout, c0, 'DisplayName', 'c_0');
yline(c0star, '--k', 'DisplayName', 'c_0^*')
title('c_0');
xlabel('Time Step');
legend;
grid on;


nexttile;
plot(out.tout, c, 'DisplayName', 'c');
yline(cstar, '--k', 'DisplayName', 'c^*')
title('c');
xlabel('Time Step');
legend;
grid on;

nexttile;
plot(out.tout, d0, 'DisplayName', 'd_0');
yline(d0star, '--k', 'DisplayName', 'd_0^*')
title('d_0');
xlabel('Time Step');
legend;
grid on;

nexttile;
plot(out.tout, d, 'DisplayName', 'd');
yline(dstar, '--k', 'DisplayName', 'd^*')
title('d');
xlabel('Time Step');
legend;
grid on;

title(t, 'Adaptive Parameters');

exportgraphics(gcf, 'param_b.png', 'ContentType', 'image', 'Resolution', 300);