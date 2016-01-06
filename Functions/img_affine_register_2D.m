function [ Ir parameters iternum ] = img_affine_register_2D( It, Is, Options )

% Process parameters
defaultoptions=struct('Metric','nmi','Interpolation','bil','MaxOptimizationFactor',1e-1,'StopOptFactor',1e-3,'LineSearchSteps',3,'StepShrinkFactor',2,'Verbose',0);
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

[sizey sizex]=size(It);
% Init parameters
d_rot = 2*pi*MAX_OPT_FACTOR;
d_tranx = sizex*MAX_OPT_FACTOR;
d_trany = sizey*MAX_OPT_FACTOR;
d_scalx = MAX_OPT_FACTOR;
d_scaly = MAX_OPT_FACTOR;
opt_factor = [d_rot d_tranx d_trany d_scalx d_scaly d_rot];
parameters = zeros(1,6);
parameters(4:5) = [1 1];

% Calculate initial error
err = img_distance(It,Is, metric, 0);

count=0;
grad = zeros(1,6);
current_factor = MAX_OPT_FACTOR;
% Run untill gradient reaches minimum
while (current_factor > STOP_OPT_FACTOR)
    GRAD_STEP = opt_factor/LINE_SEARCH_STEPS;
    
    % Calculate the error in every direction
    for i=1:numel(grad)
        delta = zeros(1,numel(grad));
        delta(i) = GRAD_STEP(i);
        Itemp = img_affine_transform(Is, create_affine_2d_transform(parameters + delta), inter);
        grad(i)=img_distance(It, Itemp, metric, 0) - err;
    end
    
    % Normalize
    ngrad = grad./sqrt(sum(grad.^2));
    
    % Perform line search along the gradient
    possible_params = zeros(LINE_SEARCH_STEPS+1,numel(grad)+1);
    possible_params(1,:) = [err parameters];
    
    for i=1:LINE_SEARCH_STEPS
        possible_params(i+1,2:end) = parameters - (opt_factor.*(i/LINE_SEARCH_STEPS)).*ngrad;
        Itemp = img_affine_transform(Is, create_affine_2d_transform(possible_params(i+1,2:end)), inter);
        possible_params(i+1,1) = img_distance(It, Itemp, metric, 0);
    end
    
    % Select the param set that brings cost funtion to minimum
    % If the current position brings it to minimum decrease step
    [err new_param_index] = min(possible_params(:,1));
    if new_param_index == 1
        opt_factor = opt_factor/STEP_SHRINK_FACTOR;
        current_factor = current_factor/STEP_SHRINK_FACTOR;
    else
        parameters = possible_params(new_param_index, 2:end);
    end
    count = count+1;
    
    if Options.Verbose      
        % Display intermidiate images
        Itemp = img_affine_transform(Is,create_affine_2d_transform(parameters), inter);
        subplot(1,3,1);
        imagesc(It./255);
        title('target');
        subplot(1,3,2);
        imagesc(Itemp./255);
        title('intermidiate');
        subplot(1,3,3);
        imagesc(abs(It-Itemp)./255);
        title('Abs diff');
        drawnow;

        disp(['parameters = ' num2str(parameters)]);
        disp(['count = ' num2str(count)]);
        disp(['scale = ' num2str(current_factor)]);
    end
end

iternum = count;
Ir = img_affine_transform(Is,create_affine_2d_transform(parameters), 'bic');

end


