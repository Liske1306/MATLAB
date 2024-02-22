clear all, close all, clc

a = [1, 3, 2];
b = [3, -1, 0];
c = [1/3, 1, -5/3];

y = orthonormal3(a,b,c)
y_normalized = orthonormal3(normalize(a),normalize(b),normalize(c))
y = orthogonal3(a,b,c);

%% ortogonalne => dot == 0
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
%% wszystkie miedzy soba ortogonalne
function y = orthogonal3(a, b, c)
    v1 = orthogonal(a,b);
    v2 = orthogonal(b,c);
    v3 = orthogonal(a,c);
    if (v1 == 1) && (v2 == 1) && (v3 == 1)
        y=1;
    else
        y=0;
    end
end
%% norma wektora
function y = vector_length(a)
    a = a.^2;
    y = round(sqrt(sum(a)),10);
end
%%
function y = normalize(a)
    y = a ./ vector_length(a);
end
%%
function y = orthonormal(a, b)
    if (orthogonal(a,b) == 1) && (vector_length(a) == 1) && (vector_length(b) == 1)
        y = 1;
    else
        y = 0;
    end
end
%%
function y = orthonormal3(a, b, c)
    if (orthogonal3(a, b, c) == 1) && (vector_length(a) == 1) && (vector_length(b) == 1) && (vector_length(c) == 1)
        y = 1;
    else
        y = 0;
    end
end