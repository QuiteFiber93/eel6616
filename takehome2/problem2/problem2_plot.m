clear; clc; close all;

% Time: t
t = 0:0.1:10;
% omega(t) = sin(t)
omega = sin(t);

% Analytic solution to int of sin^2(t)
analytic = t/2 - 1/4 * sin(2*t);

figure
plot(t, analytic)
xlabel('t')
ylabel('$\int_0^t \omega^2(\tau)d\tau$', 'Interpreter','latex')
title('Plot of \lambda(t)')
grid