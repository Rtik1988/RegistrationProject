close all;

Is=int16(imread('Ia.png'));
It=int16(imread('Ib.png'));
Options.Verbose=1;

%% mse Tests

Options.Metric='mse';
Options.StopOptFactor=1e-1;
Options.LineSearchSteps=3;
Options.StepShrinkFactor=2;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_mse_1e-1_3_2_128_128_4.mat Is It Ir

Options.Metric='mse';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=3;
Options.StepShrinkFactor=1.5;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_mse_1e-2_3_1.5_128_128_4.mat Is It Ir

Options.Metric='mse';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=3;
Options.StepShrinkFactor=2;
Options.Spacing=[64,64];
Options.RefinementLevels=3;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_mse_1e-2_3_2_64_64_3.mat Is It Ir

Options.Metric='mse';
Options.StopOptFactor=1e-3;
Options.LineSearchSteps=4;
Options.StepShrinkFactor=1.5;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_mse_1e-3_4_1.5_128_128_4.mat Is It Ir

Options.Metric='mse';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=4;
Options.StepShrinkFactor=1.5;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_mse_1e-2_4_1.5_128_128_4.mat Is It Ir

Options.Metric='mse';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=4;
Options.StepShrinkFactor=2;
Options.Spacing=[64,64];
Options.RefinementLevels=3;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_mse_1e-2_4_2_64_64_3.mat Is It Ir

%% NMI test

Options.Metric='nmi';
Options.StopOptFactor=1e-1;
Options.LineSearchSteps=3;
Options.StepShrinkFactor=2;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_nmi_1e-1_3_2_128_128_4.mat Is It Ir

Options.Metric='nmi';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=3;
Options.StepShrinkFactor=1.5;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_nmi_1e-2_3_1.5_128_128_4.mat Is It Ir

Options.Metric='nmi';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=3;
Options.StepShrinkFactor=2;
Options.Spacing=[64,64];
Options.RefinementLevels=3;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_nmi_1e-2_3_2_64_64_3.mat Is It Ir

Options.Metric='nmi';
Options.StopOptFactor=1e-3;
Options.LineSearchSteps=4;
Options.StepShrinkFactor=1.5;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_nmi_1e-3_4_1.5_128_128_4.mat Is It Ir

Options.Metric='nmi';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=4;
Options.StepShrinkFactor=1.5;
Options.Spacing=[128,128];
Options.RefinementLevels=4;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_nmi_1e-2_4_1.5_128_128_4.mat Is It Ir

Options.Metric='nmi';
Options.StopOptFactor=1e-2;
Options.LineSearchSteps=4;
Options.StepShrinkFactor=2;
Options.Spacing=[64,64];
Options.RefinementLevels=3;
Ir = img_register_bspline_2D(Is,It,Options);

save BSplineReg_nmi_1e-2_4_2_64_64_3.mat Is It Ir
