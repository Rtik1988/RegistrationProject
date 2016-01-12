function [ result ] = img_mse( Ia, Ib, is3D )
%IMG_MSE  Mean squared error between two images.
%   IMG_MSE(Ia,Ib) Calculates mean squared error between image Ia and image
%   Ib.
%
%   Arguments:
%       Ia,Ib - Images to compare
%   Output:
%       result - Mean squared error between the images
%
%   Written by Atriom Lapshin 2016

if is3D==1
    disp('3D not supported yet');
    return;
end

lenA = numel(Ia);
lenB = numel(Ib);
result = 0;

if lenA ~= lenB 
    disp('img_mse: not the same length');
    return;
end

N = numel(Ia(:,:,1));
result = (1/(N^2))*sum(sum(sqrt(sum((Ia-Ib).^2,3))));
%result = (1/(lenA^2))*sum((Ia(:) - Ib(:)).^2);

end

