clear; clc; close all;

out = sim('problem2.slx');

% plot error
figure;
plot(out.logsout.get('err').Values);
title('Error Signal');
xlabel('Time (s)');
ylabel('Error');
grid on;

% plot parameters c0, c, d, d0
theta = out.logsout.get('theta').Values.Data;
c0 = theta(:,1);
c  = theta(:,2);
d  = theta(:,3);
d0 = theta(:,4);

figure('Position', [100, 100, 800, 900]);
t = tiledlayout(4, 1, 'TileSpacing', 'compact', 'Padding', 'compact');

nexttile;
plot(out.tout, c0); title('c_0'); xlabel('Time (s)'); grid on;

nexttile;
plot(out.tout, c); title('c'); xlabel('Time (s)'); grid on;

nexttile;
plot(out.tout, d0); title('d_0'); xlabel('Time (s)'); grid on;

nexttile;
plot(out.tout, d); title('d'); xlabel('Time (s)'); grid on;

title(t, 'Adaptive Parameters');

% flip manual switch 
% sim problem2.slx

% plot parameters c0, c, d, d0
% extracting parameters (in that order) from logged signal theta