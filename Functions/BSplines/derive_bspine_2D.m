function [ ngrad ] = derive_bspine_2D( It, Is, O, Step, err, metric, Spacing )
%DERIVE_BSPINE_2D Summary of this function goes here
%   Detailed explanation goes here

grad = zeros(size(O));
O_uniform=make_init_grid(Spacing,[size(Is,1) size(Is,2)]);
sizeI = size(Is);

% Derive uneffected regions in parralel
for dim=1:2
for offx=0:3
for offy=0:3
    delta = zeros(size(O));
    
    % Jump each 4 so they won't effect each other
    for ind_x=1:4:size(O,1)
    for ind_y=1:4:size(O,2)
        delta(ind_x+offx,ind_y+offy,dim)=Step(ind_x+offx,ind_y+offy,dim);   
    end
    end
    
    Od = O + delta;
    Itemp=img_bspline_transform_2D(Is, Od, Spacing);
    
    % Calculate gradient for each point
    for ind_x=1:4:size(O,1)
    for ind_y=1:4:size(O,2)
        [regAx,regAy,regBx,regBy]=region_influenced_bspline(ind_x+offx,ind_y+offy,O_uniform,sizeI);
        I_grad = Is;
        I_grad(regAx:regBx,regAy:regBy,:) = Itemp(regAx:regBx,regAy:regBy,:);
        grad(ind_x+offx,ind_y+offy,dim)=img_distance(It, I_grad, metric, 0) - err;
    end
    end
end
end
end

% Normalize
ngrad = grad./sqrt(sum(grad(:).^2));

end

