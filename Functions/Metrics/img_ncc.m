function [ nc ] = img_ncc( Ia, Ib, is3D )
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

if is3D
    disp('3D images not supported yet');
    return;
end

nc=0;
for k=1:size(Ia,3)
    Ia_mean = mean2(Ia(:,:,k));
    Ib_mean = mean2(Ib(:,:,k));
    Ia_nomean = Ia(:,:,k) - Ia_mean;
    Ib_nomean = Ib(:,:,k) - Ib_mean;
    N_a = numel(Ia(:,:,k));
    N_b = numel(Ib(:,:,k));
    auto_corr_a = sum(reshape(Ia_nomean.*Ia_nomean,1,N_a));
    auto_corr_b = sum(reshape(Ib_nomean.*Ib_nomean,1,N_b));
    inner_prod_ab = sum(reshape(Ia_nomean.*Ib_nomean,1,N_a));
    nc = nc - inner_prod_ab/sqrt(auto_corr_a*auto_corr_b);
end

end

