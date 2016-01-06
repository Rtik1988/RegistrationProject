function [ int_pix ] = interpulate_2D_nn( I, pix )
%INTERPULATE_2D_NN  Nearest neighbour interpulate a vector of pixels.
%   INTERPULATE_2D_NN(I,pix) Performs a Nearest neighbour interpulation 
%   of vector of indecies pix from image I.
%
%   Arguments:
%       I - Source image
%       pix - Vector of indecies to interpulate
%   Output:
%       int_pix - Vaules of interpulated pixels
%
%   Written by Atriom Lapshin 2016

int_pix = zeros(1,numel(pix)/2);
[xsize,ysize] = size(I);

% Decide what locations are legal
legal = pix(1,:)>=1 & pix(1,:)<=xsize & pix(2,:)>=1 & pix(2,:)<=ysize;
if(sum(legal==1) == 0)
    return;
end

% Just take the closest index
lpix_x = round(pix(1,legal));
lpix_y = round(pix(2,legal));
int_pix(legal)=I(IndexMat2Vec(lpix_x,lpix_y,xsize));

end


% function [ int_pix ] = old_interpulate_2D_nn( I, pix )
% 
% [ysize,xsize] = size(I);
% if pix(1) < 1 || pix(1) > xsize || pix(2) < 1 || pix(2) > ysize
%     int_pix = 0;
%     return
% end
% 
% % Interpulate
% pix = round(pix);
% int_pix = I(pix(2),pix(1));
% 
% end