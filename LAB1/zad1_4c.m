clear all, close all, clc

N = 50;
L = 5;
Tmin = 0;
Tmax = N-1;
dt = 1;

t = Tmin:dt:Tmax;
x = zeros(1,length(t));

for n=0:(N-1)
    if (n >= 0) && (n <= (L-1))
        x(n+1) = 1;
    else
        x(n+1) = 0;
    end
end

figure('WindowState', 'maximized');
subplot(4,1,1)%square
plot(t,x,'.-b');
title("Signal");
xlabel('Time');
ylabel('Amplitude');
grid on, axis tight, box on;

subplot(4,1,2)%dft real
stem(t,real(dft(x)),'-r');
title("DFT real");
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;

subplot(4,1,3)%dft imag
stem(t,imag(dft(x)),'-r');
title("DFT imag");
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;

subplot(4,1,4)%dft imag
stem(t,abs(eliminate_zero_error(dft(x),0.01)),'-r');
title("DFT ampitude");
xlabel('Frequency');
ylabel('Amplitude');
grid on, axis tight, box on;

figure('WindowState', 'maximized');
stem(t,angle(eliminate_zero_error(dft(x),1)),'-r');
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