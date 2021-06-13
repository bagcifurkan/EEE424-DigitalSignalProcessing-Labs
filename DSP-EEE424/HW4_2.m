close all, clear all, clc;
n = 0:1:63
x= sqrt(3/5).^n;


DFT_16 = abs(fftshift(fft(x(1:16),16)));

figure(1);
stem([-8:1:7],DFT_16);
title(' Figure1 : DFT X16(k)');
xlabel('X(k)');
ylabel('amplitude');

DFT_64 = abs(fftshift(fft(x(1:64),64)));

figure(2);
stem([-32:1:31],DFT_64);
title(' Figure2 : DFT X64(k)');
xlabel('X(k)');
ylabel('amplitude');

part16_fft=(fft(x(1:16),16));
part64_fft=(fft(x(1:64),64));
%Part4
part4_16 = part16_fft(3);
disp(part4_16)
part4_64 = part64_fft(9);
disp(part4_64);