close all, clear all, clc
I = imread('dsp_test_image0.gif');
I = im2double(I);

T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);

mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);

invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[8 8],invdct);

subplot(1,2,1)
imshow(I)
title('Original Test Image')

M_0 = sqrt(sum(sum((I - I2).^2)));
M_1 = sqrt(sum(sum(I.^2)));
error = M_0/M_1*100;
d = sprintf('Compressed Image with DCT')
c = sprintf('Error: %.2f%%', error)

subplot(1,2,2)
imshow(I2)
title({d,c})
