function [ result ] = img_rmse( Ia, Ib )
%IMG_MSE  Root mean squared error between two images.
%   IMG_MSE(Ia,Ib) Calculates root mean squared error between image Ia and 
%   image Ib.
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

result = (1/lenA)*sqrt(sum((Ia(:) - Ib(:)).^2));

end

