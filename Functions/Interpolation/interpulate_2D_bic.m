function [ int_pix ] = interpulate_2D_bic( I, pix )
%INTERPULATE_2D_BIC  Bicubical interpulate a vector of pixels.
%   INTERPULATE_2D_BIC(I,pix) Performs a Bicubical interpulation 
%   of vector of indecies pix from image I.
%
%   Arguments:
%       I - Source image
%       pix - Vector of indecies to interpulate
%   Output:
%       int_pix - Vaules of interpulated pixels
%
%   Written by Atriom Lapshin 2016

int_pix = zeros(1,size(pix,2));
[xsize,ysize] = size(I);

% Decide what locations are legal
legal = pix(1,:)>=1 & pix(1,:)<=xsize & pix(2,:)>=1 & pix(2,:)<=ysize;
if(sum(legal) == 0)
    return;
end
lpix = pix(:,legal);

% Add zeros padding to the image
Ib = zeros(size(I) + [3,3]);
Ib(2:end-2, 2:end-2) = I;

% Build the control points vector
rpix = floor(lpix);
[off_x off_y] = ndgrid(0:3,0:3);
offsets = [off_x(:)'; off_y(:)'];
ctrl_index = reshape(repmat(rpix,16,1),2,16*size(rpix,2)) + repmat(offsets,1,size(rpix,2));
ctrl_vec_index = (ctrl_index(2,:) - 1).*size(Ib,1) + ctrl_index(1,:);

ctrl = reshape(Ib(ctrl_vec_index),16,sum(legal));

h = 1;
f_00 = ctrl(6,:);
f_10 = ctrl(7,:);
f_01 = ctrl(10,:);
f_11 = ctrl(11,:);

fx_00 = (ctrl(7,:)-ctrl(5,:))/(2*h);
fx_10 = (ctrl(8,:)-ctrl(6,:))/(2*h);
fx_01 = (ctrl(11,:)-ctrl(9,:))/(2*h);
fx_11 = (ctrl(12,:)-ctrl(10,:))/(2*h);

fy_00 = (ctrl(10,:)-ctrl(2,:))/(2*h);
fy_10 = (ctrl(11,:)-ctrl(3,:))/(2*h);
fy_01 = (ctrl(14,:)-ctrl(6,:))/(2*h);
fy_11 = (ctrl(15,:)-ctrl(7,:))/(2*h);

fxy_00 = (ctrl(11,:)-ctrl(3,:)-ctrl(9,:)+ctrl(1,:))/(4*h*h);
fxy_10 = (ctrl(12,:)-ctrl(3,:)-ctrl(10,:)+ctrl(2,:))/(4*h*h);
fxy_01 = (ctrl(15,:)-ctrl(7,:)-ctrl(13,:)+ctrl(5,:))/(4*h*h);
fxy_11 = (ctrl(16,:)-ctrl(8,:)-ctrl(14,:)+ctrl(6,:))/(4*h*h);

p = [f_00;f_10;f_01;f_11;fx_00;fx_10;fx_01;fx_11;fy_00;fy_10;fy_01;fy_11;...
     fxy_00;fxy_10;fxy_01;fxy_11];
 
A_inv = [1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;...
         0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0;...
        -3  3  0  0 -2 -1  0  0  0  0  0  0  0  0  0  0;...
         2 -2  0  0  1  1  0  0  0  0  0  0  0  0  0  0;...
         0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0;...
         0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0;...
         0  0  0  0  0  0  0  0 -3  3  0  0 -2 -1  0  0;...
         0  0  0  0  0  0  0  0  2 -2  0  0  1  1  0  0;...
        -3  0  3  0  0  0  0  0 -2  0 -1  0  0  0  0  0;...
         0  0  0  0 -3  0  3  0  0  0  0  0 -2  0 -1  0;...
         9 -9 -9  9  6  3 -6 -3  6 -6  3 -3  4  2  2  1;...
        -6  6  6 -6 -3 -3  3  3 -4  4 -2  2 -2 -2 -1 -1;...
         2  0 -2  0  0  0  0  0  1  0  1  0  0  0  0  0;...
         0  0  0  0  2  0 -2  0  0  0  0  0  1  0  1  0;...
        -6  6  6 -6 -4 -2  4  2 -3  3 -3  3 -2 -1 -2 -1;...
         4 -4 -4  4  2  2 -2 -2  2 -2  2 -2  1  1  1  1];
     
alpha = A_inv*p;

x=lpix(1,:)-rpix(1,:);
y=lpix(2,:)-rpix(2,:);
xy_1 = ones(1,numel(y));


xy = [xy_1;     x;            x.^2;           x.^3; ...
      y;     y.*x;        y.*(x.^2);      y.*(x.^3);...
      y.^2; (y.^2).*(x); (y.^2).*(x.^2); (y.^2).*(x.^3);...
      y.^3; (y.^3).*(x); (y.^3).*(x.^2); (y.^3).*(x.^3)];

int_pix(legal) = sum(alpha.*xy,1);

end


% function [ int_pix ] = old_interpulate_2D_bic( I, pix )
% 
% % Check that pixel is in legal range
% [ysize,xsize] = size(I);
% if pix(1) < 1 || pix(1) > xsize || pix(2) < 1 || pix(2) > ysize || isnan(pix(1)) || isnan(pix(2))
%     int_pix = 0;
%     return
% end
% 
% Ib = zeros(size(I) + [3,3]);
% Ib(2:end-2, 2:end-2) = I;
% 
% rpix = floor(pix);
% ctrl = Ib(rpix(2):rpix(2)+3,rpix(1):rpix(1)+3);
% % offsets =
% %   1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16
% %   1     2     3     4     1     2     3     4     1     2     3     4     1     2     3     4
% %   1     1     1     1     2     2     2     2     3     3     3     3     4     4     4     4
% 
% h = 1;
% % Need to switch between x and y
% f_00 = ctrl(2,2);
% f_10 = ctrl(2,3);
% f_01 = ctrl(3,2);
% f_11 = ctrl(3,3);
% 
% fx_00 = (ctrl(2,3)-ctrl(2,1))/(2*h);
% fx_10 = (ctrl(2,4)-ctrl(2,2))/(2*h);
% fx_01 = (ctrl(3,3)-ctrl(3,1))/(2*h);
% fx_11 = (ctrl(3,4)-ctrl(3,2))/(2*h);
% 
% fy_00 = (ctrl(3,2)-ctrl(1,2))/(2*h);
% fy_10 = (ctrl(3,3)-ctrl(1,3))/(2*h);
% fy_01 = (ctrl(4,2)-ctrl(2,2))/(2*h);
% fy_11 = (ctrl(4,3)-ctrl(2,3))/(2*h);
% 
% fxy_00 = (ctrl(3,3)-ctrl(1,3)-ctrl(3,1)+ctrl(1,1))/(4*h*h);
% fxy_10 = (ctrl(3,4)-ctrl(1,4)-ctrl(3,2)+ctrl(1,2))/(4*h*h);
% fxy_01 = (ctrl(4,3)-ctrl(2,3)-ctrl(4,1)+ctrl(2,1))/(4*h*h);
% fxy_11 = (ctrl(4,4)-ctrl(2,4)-ctrl(4,2)+ctrl(2,2))/(4*h*h);
% 
% p = [f_00;f_10;f_01;f_11;fx_00;fx_10;fx_01;fx_11;fy_00;fy_10;fy_01;fy_11;...
%      fxy_00;fxy_10;fxy_01;fxy_11];
%  
% A_inv = [1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0;...
%          0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0;...
%         -3  3  0  0 -2 -1  0  0  0  0  0  0  0  0  0  0;...
%          2 -2  0  0  1  1  0  0  0  0  0  0  0  0  0  0;...
%          0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0;...
%          0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0;...
%          0  0  0  0  0  0  0  0 -3  3  0  0 -2 -1  0  0;...
%          0  0  0  0  0  0  0  0  2 -2  0  0  1  1  0  0;...
%         -3  0  3  0  0  0  0  0 -2  0 -1  0  0  0  0  0;...
%          0  0  0  0 -3  0  3  0  0  0  0  0 -2  0 -1  0;...
%          9 -9 -9  9  6  3 -6 -3  6 -6  3 -3  4  2  2  1;...
%         -6  6  6 -6 -3 -3  3  3 -4  4 -2  2 -2 -2 -1 -1;...
%          2  0 -2  0  0  0  0  0  1  0  1  0  0  0  0  0;...
%          0  0  0  0  2  0 -2  0  0  0  0  0  1  0  1  0;...
%         -6  6  6 -6 -4 -2  4  2 -3  3 -3  3 -2 -1 -2 -1;...
%          4 -4 -4  4  2  2 -2 -2  2 -2  2 -2  1  1  1  1];
%      
% alpha = A_inv*p;
% 
% x=pix(1)-floor(pix(1));
% y=pix(2)-floor(pix(2));
% 
% xy = [1 x x^2 x^3]'*[1 y y^2 y^3];
% xy = xy(:);
% 
% int_pix = alpha'*xy;
% 
% end
% 
