function [ int_pix ] = interpulate_3D_nn( I, pix )


[ysize,xsize,zsize] = size(I);
if pix(1) < 1 || pix(1) > xsize || ...
   pix(2) < 1 || pix(2) > ysize || ...
   pix(3) < 1 || pix(3) > zsize
    int_pix = 0;
    return
end

% Interpulate
pix = round(pix);
int_pix = I(pix(2),pix(1),pix(3));

end

