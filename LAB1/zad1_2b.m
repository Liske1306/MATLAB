clear all, close all, clc

Tmin = 0;
Tmax = 2;
dt = 0.05;
n_bits = 1;
min_range = 0;
max_range = 9;
range = max_range - min_range;
max_quantization = 0;
LSB = (range/(2^n_bits))/2%połowa przedziału kwantowania

t = Tmin:dt:Tmax;

x = 5 + 2*cos(2*pi*t - (pi/2)) + 3*cos(4*pi*t);
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

    if max_quantization<(x(j)-adc)
        max_quantization = x(j)-adc;
    end
    adc_plot(j) = adc;
end

max_quantization
adc_output
figure, hold on
plot(t,x,'.-g');
xlabel('t(s)');
ylabel('x(t)');
plot(t,adc_plot,'.r');
legend('Input signal', 'Output signal')
grid on, axis tight, box on