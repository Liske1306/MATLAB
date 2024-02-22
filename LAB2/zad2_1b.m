clear all, close all, clc

haar_m = haar(8);
walsh_m = hadamard(8);
dot(haar_m,walsh_m)

function y = haar(number)
    sets = zeros(number,2);
    k=0;
    j=0;
    for i = 0 : number-1
        sets(i+1,:) = [j,k];
        if k == (2^j)-1
            j = j+1;
            k = 0;
        else  
            k = k+1;
        end
    end

    y = zeros(number, number);
    y(:,1) = 1;
    for i = 2 : number
        for t = 0: number-1
            if (t/number) >= (sets(i-1,2))/(2^sets(i-1,1)) && (t/number) < (0.5+sets(i-1,2))/(2^sets(i-1,1))
                y(t+1,i) = 1;
            elseif (t/number) >= (0.5+sets(i-1,2))/(2^sets(i-1,1)) && (t/number) < (1+sets(i-1,2))/(2^sets(i-1,1))
                y(t+1,i) = -1;
            else
                y(t+1,i) = 0;
            end
        end
    end
end