clear all;
%close all;

%load('/home/art/Documents/MATLAB/project_251215/Data/brain.mat');
load('C:\Users\artioml\Documents\MATLAB\project\Data\patients.mat');
Is=double(Is);
It=double(It);

% Is = img_to_gmm_2D(Is, 3);
% It = img_to_gmm_2D(It, 3);
 
% Set default values
%std_parameters = [pi/10, 30, 30, 0.1, 0.1, pi/30];
std_parameters = [pi/10, 10, 10, 0, 0, 0];

Options.MaxOptimizationFactor = 1/10;
Options.LineSearchSteps = 3;
Options.StepShrinkFactor = 2;
Options.Metric = 'ncc';
Options.Interpolation = 'bil';
Options.Verbose = 1;
rand_param = std_parameters.*(2*rand(1,6)-1) + [0,0,0,1,1,0];
T = create_affine_2d_transform(rand_param);
Is = img_affine_transform( Is, T, 'bil');
[Ir, reg_parameters, iternum] = img_affine_register_2D( It, Is, Options);

% for i=1:10
%     rand_param = std_parameters.*(2*rand(1,6)-1) + [0,0,0,1,1,0];
%     T = create_affine_2d_transform(rand_param);
%     Is = transform_img_2( It, T, 'bic');
%     
%     [Ir, reg_parameters, iternum] = img_affine_register_2D( It, Is, Options);
%     
%     trans_param(:,:,i)=rand_param;
%     reg_param(:,:,i)=reg_parameters;
%     I_reg(:,:,i)=Ir;
%     I_src(:,:,i)=Is;
%     Tf(:,:,i)=T;
%     Tr(:,:,i)=create_affine_2d_transform(reg_parameters);
%     itcount(i)=iternum;
%     show_img_diff(It, Ir);
%     
%     save AffineRegTest_DiffBrain.mat trans_param reg_param I_reg I_src It Tf Tr itcount
% end

