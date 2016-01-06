clear all;
close all;

Is = double(imread('Ia.png'));
It = double(imread('Ib.png'));


% Generate probability images
load GmmIsIt.mat
Is_p = img_to_gmm_2D(Is, 3, Gmm_Is);
It_p = img_to_gmm_2D(It, 3, Gmm_It);


% CostTypes: 1-ncc, 2-mse, 3=nmi, 4-mi
% DataType:
%   0 - Regular data
%   1 - Probability RGB

% Built testcase of parameters
%               MET  MOF     SOF     LSS    SSF     GRID        DATATYPE
testCase = [...
                1,   1e-1,   1e-3,   3,     2,      64, 64, 3,  0;...
                1,   1e-1,   1e-3,   3,     2,      32, 32, 2,  0;...
                1,   1e-1,   1e-3,   4,     2,      64, 64, 3,  0;...
                1,   1e-1,   5e-3,   3,     2,      64, 64, 3,  0;...
                1,   1e-1,   1e-2,   3,     2,      64, 64, 4,  0;...
                
                2,   1e-1,   1e-3,   3,     2,      64, 64, 3,  0;...
                2,   1e-1,   1e-3,   3,     2,      32, 32, 2,  0;...
                2,   1e-1,   1e-3,   4,     2,      64, 64, 3,  0;...
                2,   1e-1,   5e-3,   3,     2,      64, 64, 3,  0;...
                2,   1e-1,   1e-2,   3,     2,      64, 64, 4,  0;...
                
                3,   1e-1,   1e-3,   3,     2,      64, 64, 3,  0;...
                3,   1e-1,   1e-3,   3,     2,      32, 32, 2,  0;...
                3,   1e-1,   1e-3,   4,     2,      64, 64, 3,  0;...
                3,   1e-1,   5e-3,   3,     2,      64, 64, 3,  0;...
                3,   1e-1,   1e-2,   3,     2,      64, 64, 4,  0;...
                
                4,   1e-1,   1e-3,   3,     2,      64, 64, 3,  0;...
                4,   1e-1,   1e-3,   3,     2,      32, 32, 2,  0;...
                4,   1e-1,   1e-3,   4,     2,      64, 64, 3,  0;...
                4,   1e-1,   5e-3,   3,     2,      64, 64, 3,  0;...
                4,   1e-1,   1e-2,   3,     2,      64, 64, 4,  0;...
           ];
       
for n=1:size(testCase,1)
    
    % Read the next parameters set
    switch testCase(n,1)
        case 1
            metric='ncc';
        case 2
            metric='mse';
        case 3
            metric='nmi';
        case 4
            metric='mi';
    end
    
    switch testCase(n,9)
    case 0
        DataType='reg';
        Ia=It;
        Ib=Is;
    case 1
        DataType='prob';
        Ia=It_p;
        Ib=Is_p;
    end
    
    Options.Metric = metric;
    Options.Interpolation = 'bil';
    Options.MaxOptimizationFactor = testCase(n,2);
    Options.StopOptFactor = testCase(n,3);
    Options.LineSearchSteps = testCase(n,4);
    Options.StepShrinkFactor = testCase(n,5);
    Options.Verbose = 0;
    Options.Spacing = [testCase(n,6),testCase(n,7)];
    Options.RefinementLevels=testCase(n,8);
    
    % Perform registration
    tic;
    [ Ir_p parameters ] = img_register_bspline_2D( Ia, Ib, Options );
    reg_time=toc;
    
    % Save final transformation and get it's time
    tic;
    Ir = img_bspline_transform_2D(Is, parameters, Options.Spacing);
    single_time=toc;
    
    rel_time=reg_time/single_time;
    
    % Store results
    fname = ['ResultsBSpline_' ...
                DataType '_' ...
                metric '_' ...
                num2str(testCase(n,2)) '_' ...
                num2str(testCase(n,3)) '_' ...
                num2str(testCase(n,4)) '_' ...
                num2str(testCase(n,5)) '_' ...
                num2str(testCase(n,6)) '_' ...
                num2str(testCase(n,7)) '_' ...
                num2str(testCase(n,8)) '.mat'];
    save(fname,'It','Is','Ir','It_p','Is_p','Ir_p','parameters','reg_time','rel_time','single_time');
    
    disp(['percent complete = ' num2str(n/size(testCase,1))]);
end



