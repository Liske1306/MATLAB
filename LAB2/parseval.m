clc, clear all, close all
t = 0:1/999:1;

signal = sin(2*pi*t);
dft_sig = dft(signal);

area_sig = sum(abs(signal).^2);
area_dft = sum(abs(dft_sig).^2)/length(signal);

round(area_sig,10) == round(area_dft, 10)

function y = dft(x)
    y = zeros(size(x));
    for i=0:(length(x)-1)
      for j=0:(length(x)-1)
        y(i+1) = y(i+1) + x(j+1)*exp(-1i*2*pi/length(x)*i*j);
      end
    end
end