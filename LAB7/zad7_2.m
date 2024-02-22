clear all, close all, clc

d_ff1 = 0;
d_ff2 = 0;
d_ff3 = 0;
d_ff4 = 0;
i=0;

number = 10011;
input = dec2base(number,10) - '0';
coded = "";

while ((d_ff1~=0 || d_ff2~=0 || d_ff3~=0 || d_ff4~=0) || (i<length(input)))
    i=i+1;
    coded = append(coded,num2str(viterby_code(d_ff1,d_ff2,d_ff3,d_ff4)));
    if i<=length(input)
        d_ff4 = d_ff3;
        d_ff3 = d_ff2;
        d_ff2 = d_ff1;
        d_ff1 = input(i);
    else
        d_ff4 = d_ff3;
        d_ff3 = d_ff2;
        d_ff2 = d_ff1;
        d_ff1 = 0;
    end
end

coded = str2double(coded);
coded = dec2base(coded,10) - '0';
coded = int2bit(coded,2);
coded = reshape(coded,[16,1])' %% Zakodowana liczba

trellis = poly2trellis(4,[14 13]);
tb = 2;
decoded = vitdec(coded,trellis,tb,'trunc','hard')

function y = xor3(a,b,c)
    y = xor(a,xor(b,c));
end

function y = viterby_code(d_ff1,d_ff2,d_ff3,d_ff4)
    x1 = xor3(d_ff1,d_ff2,d_ff3);
    x2 = xor3(d_ff1,d_ff2,d_ff4);
    y = x1*2 + x2;
end