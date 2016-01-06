function [ inter ] = interpulate_2D( I, pix, type, round_inter )
%INTERPULATE_2D Interpulates pixels at location pix
%   Perform interpulation of the selected type in the 'pix' locations
%
%   Arguments:
%       I - Source image
%       pix - Vector of indecies to interpulate
%       type - nn\bil\bic
%       round_inter - Round the resulting interpulation to the nearest int
%   Output:
%       inter - Vaules of interpulated pixels
%
%   Written by Atriom Lapshin 2016

switch type
    case 'nn'
        inter = interpulate_2D_nn(I,pix);
    case 'bil'
        inter = interpulate_2D_bil(I,pix);
    case 'bic'
        inter = interpulate_2D_bic(I,pix);
end

if round_inter
    inter = round(inter);
end

end

