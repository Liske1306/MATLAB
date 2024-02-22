clear all, close all, clc

N = 20;
W = 9;
Tmin = 0;
Tmax = N-1;
dt = 1;

t = Tmin:dt:Tmax;

sinus = sin(2*pi*W/N*t);

figure('WindowState', 'maximized');
subplot(3,1,1)%sinus
plot(t,sinus,'.-b');
title("Signal");
xlabel('Time [s]');
ylabel('Amplitude [V]');
grid on, axis tight, box on;

subplot(3,1,2)%dft real
stem(t,real(dft(sinus)),'-r');
title("DFT real");
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;

subplot(3,1,3)%dft imag
stem(t,imag(dft(sinus)),'-r');
title("DFT imag");
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized');
subplot(2,1,1)%phase
stem(t,angle(dft(sinus)),'-r');
title("Phase");
xlabel('Frequency');
ylabel('Amplitude');
ylim([-pi,pi]);
grid on, box on;

subplot(2,1,2)%phase-errors
stem(t,angle(eliminate_zero_error(dft(sinus),1)),'-r');
title("Phase No Err");
xlabel('Frequency');
ylabel('Amplitude');
ylim([-pi,pi]);
grid on, box on;


function y = dft(x)
    y = zeros(size(x));
    for i=0:(length(x)-1)
      for j=0:(length(x)-1)
        y(i+1) = y(i+1) + x(j+1)*exp(-1i*2*pi/length(x)*i*j);
      end
    end
end

function y = eliminate_zero_error(x, limit)
    real_x = abs(real(x));
    imag_x = abs(imag(x));
    for i=1:length(x)
        if real_x(i)<limit
            real_x(i) = 0;
        end
        if imag_x(i)<limit
            imag_x(i) = 0;
        end
    end
    y = real_x + 1i * imag_x;
end