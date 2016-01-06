function [ result ] = img_mse( Ia, Ib )
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

lenA = numel(Ia);
lenB = numel(Ib);
result = 0;

if lenA ~= lenB 
    disp('img_mse: not the same length');
    return;
end

result = (1/(lenA^2))*sum((Ia(:) - Ib(:)).^2);

end

