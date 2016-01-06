function [ ngrad ] = derive_bspline_2D_old( It, Is, O, Step, err, metric, Spacing )
%DERIVE_BSPLINE_2D_OLD Summary of this function goes here
%   Detailed explanation goes here

grad = zeros(size(O));

% Calculate the error in every direction
for i=1:numel(grad)
    delta = zeros(size(grad));
    delta(i) = Step(i);
    Od = O + delta;
    Itemp=img_bspline_transform_2D(Is, Od, Spacing);
    grad(i)=img_distance(It, Itemp, metric, 0) - err;
end

% Normalize
ngrad = grad./sqrt(sum(grad(:).^2));

end

