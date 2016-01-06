function [ It ] = img_bspline_transform_2D( I, O, Spacing )
%IMG_BSPLINE_TRANSFORM_2D Performs B-Spline image transformation
%   This is a wrapper of 'nonrigid_registration' bspline transform by Kroon

It=zeros(size(I));

% Do transformation for each dimention in the image
for n=1:size(I,3)
    It(:,:,n) = bspline_transform_2d_double( double(O(:,:,1)),...
                                             double(O(:,:,2)),...
                                             I(:,:,n),...
                                             double(Spacing(1)),...
                                             double(Spacing(2)),...
                                             double(1));
end

end

