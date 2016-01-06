function [ int_pix ] = interpulate_2D_bil( I, pix )
%INTERPULATE_2D_BIL  Bilinear interpulate a vector of pixels.
%   INTERPULATE_2D_BIL(I,pix) Performs a bilinear interpulation of vector
%   of indecies pix from image I.
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
lpix_x = pix(1,legal);
lpix_y = pix(2,legal);

% Calculate the interpulation boundries
x_c = ceil(pix(1,legal));
x_f = floor(pix(1,legal));
y_c = ceil(pix(2,legal));
y_f = floor(pix(2,legal));

% Interpulate buttom and up X value
v_yc = (lpix_x - x_f).*I(IndexMat2Vec(x_c,y_c,xsize)) + ...
       (x_c - lpix_x).*I(IndexMat2Vec(x_f,y_c,xsize));
v_yf = (lpix_x - x_f).*I(IndexMat2Vec(x_c,y_f,xsize)) + ...
       (x_c - lpix_x).*I(IndexMat2Vec(x_f,y_f,xsize));
   
% If the ceil and floor is the same put the value of the pixel
x_equal = (x_c == x_f);
v_yc(x_equal) = I(IndexMat2Vec(x_c(x_equal),y_c(x_equal),xsize));
v_yf(x_equal) = I(IndexMat2Vec(x_c(x_equal),y_f(x_equal),xsize));

% Interpulate final value
v_bil = (lpix_y - y_f).*v_yc + (y_c - lpix_y).*v_yf;
v_bil(y_c == y_f) = v_yc(y_c == y_f);
int_pix(legal)=v_bil;

end



% % Old pixel-wise interpulation
% function [ int_pix ] = old_interpulate_2D_bil( I, pix )
% 
% % Check that pixel is in legal range
% [ysize,xsize] = size(I);
% if pix(1) < 1 || pix(1) > xsize || pix(2) < 1 || pix(2) > ysize || isnan(pix(1)) || isnan(pix(2))
%     int_pix = 0;
%     return
% end
% 
% % Calculate the interpulation boundries
% x_c = ceil(pix(1));
% x_f = floor(pix(1));
% y_c = ceil(pix(2));
% y_f = floor(pix(2));
% 
% if isnan(x_c) || isnan(x_f) || isnan(y_c) || isnan(y_f)
%     int_pix = 0;
%     return
% end
% 
% % Interpulate buttom and up X value
% if x_c ~= x_f
%     v_yc = (pix(1) - x_f)*I(y_c,x_c) + (x_c - pix(1))*I(y_c,x_f);
%     v_yf = (pix(1) - x_f)*I(y_f,x_c) + (x_c - pix(1))*I(y_f,x_f);
% else
%     v_yc = I(y_c,x_c);
%     v_yf = I(y_f,x_c);
% end
% 
% % Interpulate final value
% if y_c ~= y_f
%     int_pix = round((pix(2) - y_f)*v_yc + (y_c - pix(2))*v_yf);
% else
%     int_pix = round(v_yc);
% end
% end