clear all, close all, clc

h= [1, 2, 3, 1] ;
x = [1, 1, 0.5, -1];


y = splot_kolowy(x,h)

function y = splot_kolowy(x, h)
    L = length(x);
    y = zeros(1, L);

    for n = 1:L
        for k = 1:L
            nk_wrap = mod((n - k), L)+1;
            if (k <= L) && (k >=1) && (nk_wrap >= 1) && (nk_wrap <= L)
                y(n) = y(n) + (x(k) * h(nk_wrap));
            end
        end
    end
end