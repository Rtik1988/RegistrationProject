clear all;
close all;
ctrl = [ 1 3 5 2; 1 5 2 9; 2 2 2 2; 5 3 2 1]*200;

[sizey,sizex] = size(ctrl);

N = 1000;
result_bic = zeros(N);
result_bil = zeros(N);
result_nn = zeros(N);
x=linspace(1,sizex,N);
y=linspace(1,sizey,N);

for m=1:N
    for n=1:N
        result_bic(n,m) = interpulate_2D_bic(ctrl,[x(m) y(n)]);
        result_bil(n,m) = interpulate_2D_bil(ctrl,[x(m) y(n)]);
        result_nn(n,m) = interpulate_2D_nn(ctrl,[x(m) y(n)]);
    end
end

figure;
subplot(1,3,1), imagesc(result_bic);
title('Bicubic interpolation');
subplot(1,3,2), imagesc(result_bil);
title('Bilinear interpolation');
subplot(1,3,3), imagesc(result_nn);
title('NN interpolation');