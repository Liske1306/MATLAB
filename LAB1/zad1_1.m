
clear all, close all, clc

f = 30;
A = 1;
Tmin = -0.001;
Tmax = 0.034;
dt = 1e-6;
pulse = 0;
harmonics = 100;

t = Tmin:dt:Tmax;

for i = 1:2:harmonics
    x = A*sin(2*pi*f*t*i)/i;
    pulse = pulse + x;
end

figure
plot(t,pulse,'-b')
xlabel('t(s)')
ylabel('x(t)')
legend(['Harmonics=' num2str(harmonics)])
grid on, axis tight, box on