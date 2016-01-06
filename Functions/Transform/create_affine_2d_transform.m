function T = create_affine_2d_transform(parameters)
%CREATE_AFFINE_2D_TRANSFORM  Generate affine transform out of param vector
%   CREATE_AFFINE_2D_TRANSFORM(parameters) Creates affine transformation
%   matrix out of 6 parameters vector. The parameters are rotation,
%   displacment of x, displacment of y, scaling x, scaling y, pre-scaling
%   rotation.
%
%   Arguments:
%       parameters - Vector with the parameters
%   Output:
%       T - The matrix of the transformation
%
%   Written by Atriom Lapshin 2016

rot = parameters(1);
disp_x = parameters(2);
disp_y = parameters(3);
deform_x = parameters(4);
deform_y = parameters(5);
deform_rot = parameters(6);

Rd = [cos(deform_rot), -sin(deform_rot);...
      sin(deform_rot), cos(deform_rot)];
R = [cos(rot), -sin(rot); ...
     sin(rot), cos(rot)];
D = [deform_x 0;...
     0 deform_y];

A = R*(Rd^-1)*D*Rd;
 
T = [ A(1,:) disp_x; ...
      A(2,:) disp_y; ...
      0, 0, 1];
end
