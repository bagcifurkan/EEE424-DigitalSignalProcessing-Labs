
close all, clear all, clc;
cameraman = double(imread('cameraman.tif'));
figure(1);
imshow(cameraman, [0,255]);
title('Original image of cameraman');

for i=1:30
    X_tif{i} = double(imread( string(i)+'.tif'));
    X{i} = double(imread( string(i)+'.tif')) -127.5;
    fftX{i} = fft2(X{i});
end
fftCam = fft2(cameraman);
C = zeros(256,256);
b = ones(256,256);
fftb = fft2(b);
for i = 1:25
    A = fftX{i};
    [max1, index] = max(A);
    %finding the max colums
    [max2, index2] = max(max1);
    %finding the max
    index1 = index(index2);
    
    alphaK(i) = abs(fftCam(index1, index2)) / abs(A(index1, index2));
    
    C = C + alphaK(i).*(X_tif{i}); 
end
cameraman2 = cameraman - C;
fftCam2 = fft2(cameraman2);
[high, index] = max(fftb);
[high2, index2] = max(high);
index1 = index(index2);
beta = fftCam2(index1, index2) / fftb(index1, index2);

C = C + beta.*ones(256,256);
figure(2);
imshow(C, [0,255]);
error = 100*(( norm(cameraman - C, 'fro'))^2/( norm(cameraman, 'fro'))^2);   



%part2 
for i=1:25
    part2(i) = alphaK(i)^2 * (norm(X_tif{i}, 'fro'))^2;
end
x = part2;
for i=1:5
    [val(i),idx(i)] = min(x);
    % remove for the next iteration the last smallest value:
    x(idx(i)) = inf;
end

C = zeros(256,256);
for i = 1:30
    A = fftX{i};
    [max1, index] = max(A);
    %finding the max colums
    [max2, index2] = max(max1);
    %finding the max
    index1 = index(index2);
    
    alphaK(i) = abs(fftCam(index1, index2)) / abs(A(index1, index2));
    if (ismember(i,[7,5,15,4,8]) == 1)
        continue;
    else
        C = C + alphaK(i).*(X_tif{i}); 
    end
    
end
cameraman2 = cameraman - C;
fftCam2 = fft2(cameraman2);
[high, index] = max(fftb);
[high2, index2] = max(high);
index1 = index(index2);
beta = fftCam2(index1, index2) / fftb(index1, index2);

C = C + beta.*ones(256,256);
figure(3);
imshow(C, [0,255]);
error = 100*((norm(cameraman - C,'fro'))^2/(norm(cameraman,'fro'))^2);   

