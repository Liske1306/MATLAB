clear all, close all, clc

Ac = 2; %amplituda nośnej
fc = 1000; %częstotliwość nośnej
Am = 1; %amplituda sygnału modulującego
fm = 1000; %częstotliwość sygnału modulującego
k = Am/Ac;

t = 0:1/fc/10:3/fm-(1/fc/10);

c = Ac * cos(2*pi*fc*t); %nośna

m1 = Am * cos(2*pi*fm*t);
m2 = [ones(1,length(t)/2),zeros(1,length(t)/2)];
m3 = zeros(size(t));
for i = 1:10
    m3 = m3 + cos(2*pi * fm * i * t);
end
m3 = Am * m3;

m=m3;
s1 = c+m;                   %AM
s2 = c.*m;                  %SC
s3 = c.*(1+m*k);            %WC

s=s1;

Px = rms(s).^2;
Pfn = 1/2*(Ac^2)            %moc skladowej nosnej
Pwb = 1/2*(k^2)*(Ac^2)*Px   %moc wsteg bocznych
Pam = Pfn+Pwb               %moc calego sygnalu
Sprawnosc_modulacji = Pwb/Pam

signal_demod = envelope(s);
[USB, LSB] = envelope(s);

figure('WindowState', 'maximized'), hold on;
plot(t,signal_demod,'-b');
plot(t,m,'-r');
title("Signal");
xlabel('Time');
ylabel('s');
legend('signal demodulated', 'original signal')
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
plot(t,USB,'-b');
plot(t,LSB,'-r');
title("Signal");
xlabel('Time');
ylabel('s');
legend('USB', 'LSB')
grid on, axis tight, box on;

figure('WindowState', 'maximized');
subplot(2,1,1), hold on
plot(t,s,'-b');
title("Modulated signal");
xlabel('Time');
ylabel('s');
grid on, axis tight, box on;

subplot(2,1,2)
stem(10*fc/length(t)*(0:length(t)-1),abs(fft(s))/length(t),'-b');
title("FFT s(t)");
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;