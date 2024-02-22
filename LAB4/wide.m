clear all, close all, clc
% Parameters
Ac = 1;         % Carrier amplitude
fc = 1000;      % Carrier frequency
beta = 5;       % Modulation index
alpha = 1;      % Constant
m = 1;          % Modulating signal amplitude
fm = 50;        % Modulating signal frequency

% Time vector
t = 0:0.001:1;

% FM modulation using Bessel function
fm_modulated_signal = Ac * cos(2*pi*fc*t + beta * besselj(0, alpha * m * cos(2*pi*fm*t)));

% Plot the results
figure;
subplot(2,1,1);
plot(t, m * cos(2*pi*fm*t)); % Plot the modulating signal
title('Modulating Signal');
xlabel('Time');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, fm_modulated_signal); % Plot the FM-modulated signal
title('FM-Modulated Signal using Bessel Function');
xlabel('Time');
ylabel('Amplitude');

