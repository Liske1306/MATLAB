clear all, close all, clc

number_of_samples = 100;
qam_number = 4;
zeros_between_data = 10;

dataIn = randi([0 1],number_of_samples,1);
dataSymbolsIn = bit2int(dataIn,log2(qam_number));
data = qammod(dataSymbolsIn,qam_number,'bin');

real_part = real(data);
imag_part = imag(data);

real_interpolation = zeros(1,(length(data)*zeros_between_data));
imag_interpolation = zeros(1,(length(data)*zeros_between_data));
for i=1:length(data)
    real_interpolation(i*zeros_between_data) = real_part(i);
    imag_interpolation(i*zeros_between_data) = imag_part(i);
end

real_interpolation = [real_interpolation(zeros_between_data:length(real_interpolation)),zeros(1,zeros_between_data-1)];
imag_interpolation = [imag_interpolation(zeros_between_data:length(imag_interpolation)),zeros(1,zeros_between_data-1)];

real_pulsed = real_interpolation;
imag_pulsed = imag_interpolation;
for i=2:length(real_interpolation)
    if ((real_pulsed(i)==0) && (imag_pulsed(i)==0))
        real_pulsed(i) = real_pulsed(i-1);
        imag_pulsed(i) = imag_pulsed(i-1);
    end        
end

t_mod = linspace(0,1,length(real_pulsed));

carrier_freq = 50;
real_mod = 2*cos(2*pi*carrier_freq*t_mod).*real_pulsed;
imag_mod = 2*sin(2*pi*carrier_freq*t_mod).*imag_pulsed;
modulated_signal = real_mod + imag_mod;

%% Add noise
%snr=3;
%modulated_signal = awgn(modulated_signal, snr, 'measured');

%% Add phase shift
phase_shift = pi/2;
modulated_signal = real(modulated_signal .* exp(1j * phase_shift));

%% Demodulation
shifted_90=imag(hilbert(modulated_signal-mean(modulated_signal)));

demod1 = (modulated_signal.*cos(2*pi*carrier_freq*t_mod))+(shifted_90.*sin(2*pi*carrier_freq*t_mod));
demod2 = (-modulated_signal.*sin(2*pi*carrier_freq*t_mod))+(shifted_90.*cos(2*pi*carrier_freq*t_mod));

filtered1 = lowpass(demod1,carrier_freq,1000);
filtered2 = lowpass(demod2,carrier_freq,1000);

filtered1_down = downsample(filtered1./2,zeros_between_data,2);
filtered2_down = downsample(filtered2./2,zeros_between_data,2);

demod = reshape(qamdemod(filtered1_down-1i*filtered2_down,qam_number,'bin',OutputType = 'bit'),1,[]);

error_number=0;
for i=1:length(demod)
    if demod(i) ~= dataIn(i)
        error_number = error_number+1;
    end
end
error_number
%% Plot

figure('WindowState', 'maximized'), hold on;
stem(dataIn);
title('Signal');
xlabel('Time');
ylabel('Amplitude');
scatterplot(data,1,0,'g.');
xlabel('In-Phase');
ylabel('Quadrature');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
stem(real_interpolation);
title('Interpolation Real Part Signal');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
stem(imag_interpolation);
title('Interpolation Imag Part Signal');
xlabel('Time');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
stem(real_pulsed,'Marker', 'none');
title('Real Part Signal Pulsed');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
stem(imag_pulsed,'Marker', 'none');
title('Imag Part Signal Pulsed');
xlabel('Time');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
plot(t_mod,real_mod);
title('Real Part Signal Modulated');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
plot(t_mod,imag_mod);
title('Imag Part Signal Modulated');
xlabel('Time');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
plot(t_mod,filtered1);
title('Real Part Signal Modulated');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
plot(t_mod,filtered2);
title('Imag Part Signal Modulated');
xlabel('Time');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
subplot(1,2,1)
stem(filtered1_down);
title('Modulated Real Signal Downsampled');
xlabel('Time');
ylabel('Amplitude');
subplot(1,2,2)
stem(filtered2_down);
title('Modulated Imag Signal Downsampled');
xlabel('Time');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized'), hold on;
stem(dataIn);
stem(demod);
title('Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');
legend('Original signal', 'Demodulated signal')
grid on, axis tight, box on;