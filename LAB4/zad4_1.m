clear all, close all, clc

fc = 100;
fs = 10;
Amp = 1;
Ac = 1;
kf = 0.1;

t = 0:(1/fs/1000):(1/fs)-(1/fs/1000);

m1 = Amp * cos(2*pi*fs*t);
m2 = zeros(size(t));
for i=1:length(t)
    if (t(i)>=0) && (t(i)<1/2/fs)
        m2(i) = 0.9;
    elseif (t(i)>=1/2/fs) && (t(i)<1/fs)
        m2(i) = -0.6;
    end
end

m=m2;

am_ac = Amp/Ac
beta = Ac * kf / fc
%beta = 5;
modulated = Ac*fmmod(m,fc,1000,kf);
my_modulated = Ac*my_fm(m,fc,1000,kf);
widmo = abs(fft(my_modulated));
%wide_modulation = Ac*cos((2*pi*fc*t)+(beta*besselj(0,m)));
wide_modulation = cos(2*pi*fc*t + beta * besselj(0, beta) * cumsum(m)/fs);
%wide_modulation = cos(2*pi*fc*t + beta * besselj(0, beta * cumsum(m)/fs));

carson = 2*(beta*fc+fs)
one_percent = carson*0.01


Pm = rms(m).^2     %sygnal modulujacy
Pfm = rms(my_modulated)^2            %moc sygnału zmodulowanego
Sprawnosc_modulacji = Pm/Pfm 


s_hilbert = hilbert(my_modulated);
instantaneous_phase = unwrap(angle(s_hilbert));
s_demod = diff(instantaneous_phase) * fs / (2*pi);

figure('WindowState', 'maximized');
subplot(2,1,1), hold on;
plot(t,m,'-b');
%plot(t,modulated,'-g');
plot(t,my_modulated,'-r');
%plot(t, wide_modulation,'-r');
%plot(t(1:end-1),s_demod,'-m');
%plot(t,fmdemod(wide_modulation,fc,1000,kf),'-g');
%title("Beta = "+beta+", Am/Ac = "+am_ac+", kf = "+kf);
xlabel('Time');
ylabel('Amplitude');
legend('Signal','Modulation');
grid on, axis tight, box on;

subplot(2,1,2)
plot(t,m,'-b');
plot(t,fmdemod(wide_modulation,fc,1000,kf),'-g');
%title("Beta = "+beta+", Am/Ac = "+am_ac+", kf = "+kf);
xlabel('Time');
ylabel('Amplitude');
legend('Demod');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
stem(10*fc/length(t)*(0:length(t)-1),widmo/length(t),'-b');
yline(Ac*0.01,'--m')
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;

function y = my_fm(signal, fc, fs, kf)
    t= linspace(0,length(signal),fs);
    integrated_signal = cumsum(signal)/fs;
    y = cos(2*pi * (fc*t+kf*integrated_signal));
end
