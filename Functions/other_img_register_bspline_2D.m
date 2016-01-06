function [ Ir parameters iternum ] = img_register_bspline_2D( It, Is, Options )

% Process parameters
defaultoptions=struct('Metric','nmi','Interpolation','bil','MaxOptimizationFactor',1e-1,...
                       'StopOptFactor',1e-3,'LineSearchSteps',3,'StepShrinkFactor',2,...
                       'Verbose',0,'Spacing',[128,128],'RefinementLevels',4);
if(~exist('Options','var')), Options=defaultoptions;
else
    tags = fieldnames(defaultoptions);
    for i=1:length(tags),
        if(~isfield(Options,tags{i})), Options.(tags{i})=defaultoptions.(tags{i}); end
    end
    if(length(tags)~=length(fieldnames(Options))),
        warning('image_registration:unknownoption','unknown options found');
    end
end

% Consts
MAX_OPT_FACTOR = Options.MaxOptimizationFactor;
LINE_SEARCH_STEPS = Options.LineSearchSteps;
STEP_SHRINK_FACTOR = Options.StepShrinkFactor;
STOP_OPT_FACTOR = Options.StopOptFactor;
metric = Options.Metric;
inter = Options.Interpolation;
Spacing=Options.Spacing;
RefinementLevels=Options.RefinementLevels;

O=make_init_grid(Spacing,[size(Is,1) size(Is,2)]);

% refine few times
for i=1:RefinementLevels
    
% Init parameters
d_cpointx = 2*Spacing(1);
d_cpointy = 2*Spacing(2);
opt_factor=[];
opt_factor(:,:,1) = d_cpointx*ones([size(O,1) size(O,2)]);
opt_factor(:,:,2) = d_cpointy*ones([size(O,1) size(O,2)]);

% Calculate initial error
err = img_distance(It,Is, metric);

count=0;
grad = zeros(size(O));
current_factor = MAX_OPT_FACTOR;

% Run untill gradient reaches minimum
while (current_factor > STOP_OPT_FACTOR)
    GRAD_STEP = opt_factor/LINE_SEARCH_STEPS;
    
    % Calculate the error in every direction
    for i=1:numel(grad)
        delta = zeros(size(grad));
        delta(i) = GRAD_STEP(i);
        Od = O + delta;
        Itemp=img_bspline_transform_2D(Is, Od, Spacing);
        grad(i)=img_distance(It, Itemp, metric) - err;
    end
    
    % Normalize
    ngrad = grad./sqrt(sum(grad(:).^2));
    
    % Perform line search along the gradient
    possible_O = zeros(LINE_SEARCH_STEPS+1,numel(grad)+1);
    possible_O(1,:) = [err O(:)'];
    
    for i=1:LINE_SEARCH_STEPS
        possible_O_temp = O - (opt_factor.*(i/LINE_SEARCH_STEPS)).*ngrad;
        possible_O(i+1,2:end) = possible_O_temp(:)';
        Itemp=img_bspline_transform_2D(Is, possible_O_temp, Spacing);
        possible_O(i+1,1) = img_distance(It, Itemp, metric);
    end
    
    % Select the param set that brings cost funtion to minimum
    % If the current position brings it to minimum decrease step
    [err new_param_index] = min(possible_O(:,1));
    if new_param_index == 1
        opt_factor = opt_factor/STEP_SHRINK_FACTOR;
        current_factor = current_factor/STEP_SHRINK_FACTOR;
    else
        O = reshape(possible_O(new_param_index, 2:end),size(O));
    end
    count = count+1;
    
    if Options.Verbose      
        % Display intermidiate images
        Itemp=img_bspline_transform_2D(Is, O, Spacing);
        subplot(1,4,1);
        imagesc(It);
        title('target');
        subplot(1,4,2);
        imagesc(Itemp);
        title('intermidiate');
        subplot(1,4,3);
        imagesc(abs(Is-It),[1,100]);
        title('Abs. diff before');
        subplot(1,4,4);
        imagesc(abs(Itemp-It),[1,100]);
        title('Abs. diff');
        drawnow;

        disp(['count = ' num2str(count)]);
        disp(['scale = ' num2str(current_factor)]);
        disp(['err = ' num2str(err)]);
    end
end

[O,Spacing]=refine_grid(O,Spacing,size(Is));
end

iternum = count;
Ir=img_bspline_transform_2D(Is, O, Spacing);
parameters = O;

end
