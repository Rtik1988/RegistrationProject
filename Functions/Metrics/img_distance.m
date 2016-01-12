function [ distance ] = img_distance( Ia, Ib, metric, is3D )
%IMG_DISTANCE  Calculate distance between two images.
%   IMG_DISTANCE(Ia,Ib,metric) Calculates distrance from image Ia to image
%   Ib using the selected metric.
%
%   Arguments:
%       Ia,Ib - Images to compare
%       metric - The metric to calculate
%   Output:
%       distance - The resulting distance
%
%   Written by Atriom Lapshin 2016

switch metric
    case 'mi'
        distance = img_mi(Ia,Ib,is3D);
    case 'mse'
        distance = img_mse(Ia,Ib,is3D);
    case 'nmi'
        distance = img_nmi(Ia,Ib,is3D);
    case 'rmse'
        distance = img_rmse(Ia,Ib);
    case 'ncc'
        distance = img_ncc(Ia,Ib,is3D);
    case 'cr'
        distance = img_cr(Ia,Ib);
end


end

