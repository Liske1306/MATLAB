clear all, close all, clc

fs=1000;

t = 0:6*pi/fs:6*pi-(6*pi/fs);

orthogonal(sin(t),cos(t))
orthogonal(sin(2*t),cos(2*t))
orthogonal(sin(2*t),cos(543*t))
orthogonal(sin(t+pi/100),cos(t+2*pi/100))
orthogonal(sin(t+pi/100),cos(t+pi/100))

function y = orthogonal(a, b)
    if length(a) == length(b)
        c = a.*b;
        c = sum(c);
        if round(c,10) == 0
            y=1;
        else
            y=0;
        end
    else
        y=0;
    end
end
