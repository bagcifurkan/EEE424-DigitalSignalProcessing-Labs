close all, clear all, clc

test_image0 = imread('dsp_test_image0.gif');
figure(1)
subplot(2,3,1)
imshow(test_image0);
title('Original Test Image')

double = double(test_image0);
[U,S,V] = svd(double,'econ');

figure(2);
semilogy(diag(S));
title('Magnitude of the singular values');
xlabel('Singular value');
ylabel('Magnitude');

figure(3);
plot(cumsum(diag(S)/sum(diag(S))))
title('Cumulative Energy');
xlabel('Singular value');
ylabel('Energy');

%xlabel('Time(s)');
%ylabel('The number of ');

error_array = [];
for N=5:30:150
    
    C = S; %copying singular values

    % discard the diagonal values not required for compression
    C(N+1:end,:)=0;
    C(:,N+1:end)=0;

    % Construct an Image using the selected singular values
    D=U*C*V';
    
    % display and compute error
    %figure(2)
    figure(1)
    subplot(2,3,(N-5)/30 +2)
    
    M_0 = sqrt(sum(sum((double - D).^2)));
    M_1 = sqrt(sum(sum(double.^2)));
    error = M_0/M_1*100;
    
    a = sprintf('Truncation Value: %d ', N);
    b = sprintf('Using %.2f%% of the original storage ', 100*(N*1025/(512^2)));
    d = sprintf('Compression Ratio: %.2f',(512^2)/(N*1025));
    c = sprintf('Error: %.2f%%', error)
    imshow(uint8(D));
   
    title({a,b,d,c})
end

for N=5:10:500
    C = S;
    C(N+1:end,:)=0;
    C(:,N+1:end)=0;
    D=U*C*V';
    
    M_0 = sqrt(sum(sum((double - D).^2)));
    M_1 = sqrt(sum(sum(double.^2)));
    
   error_array = [error_array ; M_0/M_1*100];
end
figure(4);
plot([5:10:500],error_array);
title("Error");
xlabel('Truncation value');
ylabel('Error Rate (%)');

%imwrite(test_image0,'Test.jpg');
%XJPG = imread('Test.jpg');
%M_0 = sqrt(sum(sum((double - XJPG).^2)));
%M_1 = sqrt(sum(sum(double.^2)));
%error = M_0/M_1*100;
%print(error)
