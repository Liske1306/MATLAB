clear all, close all, clc

A = 10;
f1 = 1;
f2 = 100;
fs = 3000;
phase = 2*pi/11;

t = 0:6*pi/fs:6*pi-(6*pi/fs);

%% Signal modulation
signal1 = A*sin(t*f1);
signal2 = A*sin(t*f1*5);
carrier_sin = A*sin(t*f2);
carrier_cos = A*cos(t*f2);
modulated = (signal1.*carrier_sin) - (signal2.*carrier_cos);

%% Signal modulation with phase shift
signal1_phase = A*sin(t*f1+phase);
signal2_phase = A*sin(t*f1*5+phase);
carrier_sin_phase = A*sin(t*f2+phase);
carrier_cos_phase = A*cos(t*f2+phase);
modulated_phase = (signal1_phase.*carrier_sin_phase) - (signal2_phase.*carrier_cos_phase);

%% Demodulation
modulated_sin = modulated .* carrier_sin;
modulated_cos = -modulated .* carrier_cos;

demodulated_sin = lowpass(modulated_sin,f2,fs);
demodulated_cos = lowpass(modulated_cos,f2,fs);

%% Plot
figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
plot(t,signal1,'-b');
title('Signal1');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
plot(t,signal2,'-b');
title('Signal2');
xlabel('Time');
ylabel('Amplitude');


figure('WindowState', 'maximized'), hold on;
subplot(2,1,1)
plot(t,modulated,'-b');
title('Modulated signal');
xlabel('Time');
ylabel('Amplitude');
subplot(2,2,3)
plot(t,modulated_sin,'-b');
title('Modulated signal * sin');
xlabel('Time');
ylabel('Amplitude');
subplot(2,2,4)
plot(t,modulated_cos,'-b');
title('Modulated signal * cos');
xlabel('Time');
ylabel('Amplitude');

figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
plot(t,demodulated_sin,'-b');
title('Signal1 demodulated');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
plot(t,demodulated_cos,'-b');
title('Signal2 demodulated');
xlabel('Time');
ylabel('Amplitude');