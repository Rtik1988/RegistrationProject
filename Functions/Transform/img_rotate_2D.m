function [ Ir ] = img_rotate_2D( I, angle, inter)
%IMG_ROTATE_2D Rotate the image by a givven angle
%   Rotates the image by 'angle' radians, with interpulation method inter
%
%   Arguments:
%       I - Source image
%       angle - rotation angle in radians
%       inter - nn\bil\bic
%   Output:
%       Ir - The resulting image
%
%   Written by Atriom Lapshin 2016

R = [cos(angle), -sin(angle), 0; ...
     sin(angle), cos(angle), 0; ...
     0, 0, 1];

Ir = img_affine_transform(I, R, inter);

end






% function [ Ir ] = img_rotate_2D_old( I, angle, inter )
% 
% % Calculate rotation matrix
% R = [cos(angle), -sin(angle); sin(angle), cos(angle)];
% 
% % Pre-allocate new image matrix
% [ysize,xsize] = size(I);
% 
% new_corners = R*[0 xsize 0 xsize; 0 0 ysize ysize];
% 
% min_x = min(new_corners(1,:));
% max_x = max(new_corners(1,:));
% min_y = min(new_corners(2,:));
% max_y = max(new_corners(2,:));
% 
% new_x_size = ceil(max_x - min_x);
% new_y_size = ceil(max_y - min_y);
% Ir = 255 * ones(new_y_size, new_x_size, 'uint8');
% 
% % Define the dislocation parameter
% dis_x = min_x;
% dis_y = min_y;
% 
% % Go through every pixel and interpulate
% for n=1:new_x_size
%     for m=1:new_y_size
%         orig_pix = (R^-1)*[n+dis_x;m+dis_y];
%         if strcmp(inter,'nn')
%             Ir(m,n) = interpulate_2D_nn(I, orig_pix);
%         elseif strcmp(inter,'bil')
%             Ir(m,n) = interpulate_2D_bil(I, orig_pix);
%         end
%     end
% end
% 
% end

