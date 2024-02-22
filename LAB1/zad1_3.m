clear all, close all, clc

f = 3000;
Tmin = 0;
Tmax = 4e-3;
dt_org = 1/100000;
dt = 1/8000;%fs
n_bits = 8;
min_range = -1.1;
max_range = 1.1;
range = max_range - min_range;

t = Tmin:dt:Tmax;
t_org = Tmin:dt_org:Tmax;

x = sin(2*pi*f*t);
x_org = sin(2*pi*f*t_org);
adc_plot = zeros(1,length(x));
adc_output = zeros(length(x),n_bits);

for j = 1:length(t)%SAR ADC
    adc = min_range;

    for i = 1:1:n_bits
        adc = adc + range/(2^i);
        adc_output(j,i)=1;
        if adc>x(j)
            adc = adc - range/(2^i);
            adc_output(j,i)=0;
        end
    end
    adc_plot(j) = adc;
end

x_fft = dft(adc_plot);

figure('WindowState', 'maximized');
subplot(3,1,1), hold on
plot(t_org,x_org,'-b');
plot(t,adc_plot,'.-r');
subplot(3,1,2)
stem(t,real(x_fft),'-r');
subplot(3,1,3)
stem(t,imag(x_fft),'-r');
grid on, axis tight, box on

function y = dft(x)
    y = zeros(size(x));
    for i=0:(length(x)-1)
      for j=0:(length(x)-1)
        y(i+1) = y(i+1) + x(j+1)*exp(-1i*2*pi/length(x)*i*j);
      end
    end
end