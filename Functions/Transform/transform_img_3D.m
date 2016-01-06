function [ Ir ] = transform_img_3D( I, T, inter )
%TRANSFORM_IMG_3D Transform 3D image using matrix T
%
%   Arguments:
%       I - Source image
%       T - Transformation matrix
%       inter - nn\bil\bic
%   Output:
%       Ir - The resulting image
%
%   Written by Atriom Lapshin 2016

% Pre-allocate new image matrix
[ysize,xsize,zsize,csize] = size(I);

Ir = zeros(ysize, xsize, zsize, csize, 'uint8');

% Define the dislocation parameter
dis_x = xsize/2;
dis_y = ysize/2;
dis_z = zsize/2;

% Go through every pixel and interpulate
T_inv = (T^-1);
for c=1:csize
    for k=1:zsize
        for n=1:xsize
            for m=1:ysize
                orig_vox = T_inv*[n-dis_x;m-dis_y;k-dis_z;1] + [dis_x;dis_y;dis_z;0];
                orig_vox = orig_vox./(ones(4,1)*orig_vox(4));
                if strcmp(inter,'nn')
                    Ir(m,n,k,c) = interpulate_3D_nn(I(:,:,:,c), orig_vox);
                elseif strcmp(inter,'tril')
                    disp('Not supported');
                elseif strcmp(inter,'tric')
                    disp('Not supported');
                end
            end
        end
    end
end

end

