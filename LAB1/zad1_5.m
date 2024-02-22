clear all, close all, clc

h = [1,2,3,1];
x = [1,1,0.5,-1,2,1,4];

y= splot_liniowy(x,h)

function y = splot_liniowy(x,h) 
    y = zeros(1,length(x)+length(h));
    for n = 1:(length(x)+length(h))
        for k = 1:(length(x)+length(h)-1)
            
            if ((n-k) >= 1) && ((n-k) <= length(h)) 
                hnk = h(n-k);
            else
                hnk = 0;
            end

            if (k >= 1) && (k <= length(x)) 
                xk = x(k);
            else
                xk = 0;
            end
            y(n) = y(n) + (xk * hnk);
        end
    end
end