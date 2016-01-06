function show_img_diff( Ia, Ib )
%SHOW_IMG_DIFF  Crate plot of the images and their difference.
%   SHOW_IMG_DIFF(Ia,Ib) Creates figure with 3 sub images - A, B and Diff.
%
%   Arguments:
%       Ia,Ib - Images to compare
%
%   Written by Atriom Lapshin 2016

figure;

subplot(1,3,1);
imagesc(double(Ia));

subplot(1,3,2);
imagesc(double(Ib));

subplot(1,3,3);
imagesc(abs(double(Ia) - double(Ib)));

drawnow;

end

