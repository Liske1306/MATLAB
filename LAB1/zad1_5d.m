clear all, close all, clc

h = [1,2,3,1];
x = [1,1,0.5,-1,2,1,4];

y = splot_liniowy_kolowym(x,h);

function y = dft(x)
    y = zeros(size(x));
    for i=0:(length(x)-1)
      for j=0:(length(x)-1)
        y(i+1) = y(i+1) + x(j+1)*exp(-1i*2*pi/length(x)*i*j);
      end
    end
end

function y = splot_liniowy_kolowym(x,h)
    dlugosc = length(x)+length(h)-1;
    hn = zeros(1,dlugosc);
    xn = zeros(1,dlugosc);
    
    for i = 1:length(x)
        xn(i) = x(i);
    end

    for i = 1:length(h)
        hn(i) = h(i);
    end
    dft_xh = dft(xn) .* dft(hn);
    dft_x = dft(xn)
    dft_h = dft(hn)
    y = real(ifft(dft_xh))
end
