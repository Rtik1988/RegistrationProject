function [ nc ] = img_ncc( Ia, Ib )
%IMG_NCC  Normalized cross corralation between two images.
%   IMG_NCC(Ia,Ib) Calculates normalized cross corralation between image Ia
%   and image Ib.
%
%   Arguments:
%       Ia,Ib - Images to compare
%   Output:
%       nc - Calculates normalized cross corralation between the images
%
%   Written by Atriom Lapshin 2016

auto_corr_a = sum(reshape(Ia.*Ia,1,numel(Ia)));
auto_corr_b = sum(reshape(Ib.*Ib,1,numel(Ia)));
inner_prod_ab = sum(reshape(Ia.*Ib,1,numel(Ia)));
nc = -1*inner_prod_ab/sqrt(auto_corr_a*auto_corr_b);

end

