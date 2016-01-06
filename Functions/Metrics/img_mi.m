function [ mi ] = img_mi( Ia, Ib, is3D )
%IMG_MI  Mutual information between two images.
%   IMG_MI(Ia,Ib) Calculates mutual information between image Ia and image
%   Ib.
%
%   Arguments:
%       Ia,Ib - Images to compare
%       is3D - Is the image is 3 spatialy 3 dimensional
%   Output:
%       mi - Mutual information between the images
%
%   Written by Atriom Lapshin 2016

if is3D
    jhst = joint_hist_3D(Ia,Ib);
else
    jhst = joint_hist(Ia,Ib);
end

hsta = sum(jhst,1);
hstb = sum(jhst,2);

Ha = sum(-hsta(hsta~=0).*log2(hsta(hsta~=0)));
Hb = sum(-hstb(hstb~=0).*log2(hstb(hstb~=0)));

Hab = -jhst(jhst~=0).*log2(jhst(jhst~=0));
Hab = sum(Hab(:));

mi = -1*(Ha + Hb - Hab);

end

