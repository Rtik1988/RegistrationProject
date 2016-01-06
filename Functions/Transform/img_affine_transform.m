function [ Ir ] = img_affine_transform( I, T, inter )
%IMG_AFFINE_TRANSFORM Transform image using a matrix
%   Performs image transformation using T matrix with selected
%   interpulation
%
%   Arguments:
%       I - Source image
%       T - Transformation to perform
%       inter - nn\bil\bic
%   Output:
%       Ir - The resulting image
%
%   Written by Atriom Lapshin 2016

    % Pre-allocate new image matrix
    [xsize,ysize,zsize] = size(I);
    
    % Define the dislocation parameter
    dis_x = xsize/2;
    dis_y = ysize/2;

    [x,y]=ndgrid(1:xsize,1:ysize);
    
    New_xy = [x(:)';y(:)';ones(1,numel(x))] - [dis_x;dis_y;0]*ones(1,numel(x));
    Orig_xy = (T^-1)*New_xy + [dis_x;dis_y;0]*ones(1,numel(x));
    Orig_xy = Orig_xy(1:2,:)./(ones(2,1)*Orig_xy(3,:));
    
    % Transform each dimention in the same 2D way
    Ir = zeros(xsize,ysize,zsize);
    for n=1:zsize
       Ir(:,:,n) = reshape(interpulate_2D(I(:,:,n),Orig_xy,inter,1),xsize,ysize); 
    end
    
end








% function [ Ir ] = transform_img_old_1( I, T, inter )
% % Fit image in a square
% 
% % Pre-allocate new image matrix
% [ysize,xsize] = size(I);
% 
% new_corners = T*[0 xsize 0 xsize; 0 0 ysize ysize; 1 1 1 1];
% 
% new_corners = new_corners./(ones(3,1)*new_corners(3,:));
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
%         orig_pix = (T^-1)*[n+dis_x;m+dis_y;1];
%         orig_pix = orig_pix./(ones(3,1)*orig_pix(3));
%         if strcmp(inter,'nn')
%             Ir(m,n) = interpulate_2D_nn(I, orig_pix);
%         elseif strcmp(inter,'bil')
%             Ir(m,n) = interpulate_2D_bil(I, orig_pix);
%         end
%     end
% end
% 
% end

% function [ Ir ] = transform_img_old_2( I, T, inter )
% % Non vectoric version
% 
% % Pre-allocate new image matrix
% [ysize,xsize,zsize] = size(I);
% 
% Ir = zeros(ysize, xsize, zsize, 'uint8');
% 
% % Define the dislocation parameter
% dis_x = xsize/2;
% dis_y = ysize/2;
% 
% 
% % Go through every pixel and interpulate
% for k=1:zsize
%     for n=1:xsize
%         for m=1:ysize
%             orig_pix = (T^-1)*[n-dis_x;m-dis_y;1] + [dis_x;dis_y;0];
%             orig_pix = orig_pix./(ones(3,1)*orig_pix(3));
%             if strcmp(inter,'nn')
%                 Ir(m,n,k) = interpulate_2D_nn(I(:,:,k), orig_pix);
%             elseif strcmp(inter,'bil')
%                 Ir(m,n,k) = interpulate_2D_bil(I(:,:,k), orig_pix);
%             elseif strcmp(inter,'bic')
%                 Ir(m,n,k) = interpulate_2D_bic(I(:,:,k), orig_pix);
%             end
%         end
%     end
% end
% 
% end
% 
