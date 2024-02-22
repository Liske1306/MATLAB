clear all, close all, clc

Tmin = 0;
Tmax = 2;
dt = 0.05;

t = Tmin:dt:Tmax;

x = 5 + 2*cos(2*pi*t - (pi/2)) + 3*cos(4*pi*t);

y = dft(x);
y(1)=[];

figure('WindowState', 'maximized');
subplot(3,1,1);
plot(t,x,'-g');
grid on, axis tight, box on

subplot(3,1,2);
t(length(t))=[];
stem(t,real(y),'-b');
grid on, axis tight, box on

subplot(3,1,3);
stem(t,imag(y),'-b');
grid on, axis tight, box on

function y = dft(x)
    y = zeros(size(x));
    for i=0:(length(x)-1)
      for j=0:(length(x)-1)
        y(i+1) = y(i+1) + x(j+1)*exp(-1i*2*pi/length(x)*i*j);
      end
    end
end