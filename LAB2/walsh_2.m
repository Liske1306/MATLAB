clear all, close all, clc

t = -0.5:2/1023:1.5;

signal = zeros(size(t));
for i = 1:512
    if i<256
        signal(i+256) = 0.5;
    else
        signal(i+256) = i/512;
    end
end


%%
N = 1024;  % Length of Walsh (Hadamard) functions
hadamardMatrix = hadamard(N);

HadIdx = 0:N-1;                          % Hadamard index
M = log2(N)+1;                           % Number of bits to represent the index

binHadIdx = fliplr(dec2bin(HadIdx,M))-'0'; % Bit reversing of the binary index
binSeqIdx = zeros(N,M-1);                  % Pre-allocate memory
for k = M:-1:2
    % Binary sequency index 
    binSeqIdx(:,k) = xor(binHadIdx(:,k),binHadIdx(:,k-1));
end
SeqIdx = binSeqIdx*pow2((M-1:-1:0)');    % Binary to integer sequency index
walshMatrix = hadamardMatrix(SeqIdx+1,:); % 1-based indexing
%%
haarMatrix = haar(1024);
sum(dot(walshMatrix, haarMatrix))
%%
L = 4;
approximation = zeros(size(t));
for n = 1 : L
    approximation = approximation + dot(signal , walshMatrix(:,n))*walshMatrix(:,n);
end
approximation = approximation/length(approximation);

figure, hold on
plot(t, signal, "-r")
plot(t, approximation, "--b")
ylim([0,1]);
xlim([-0.1,1.1])
title("Approximation by Walsh functions");
xlabel('Time');
ylabel('Amplitude');

%%
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