load('inter3dBrain.mat');

% Init result vectors
rot_x = zeros(3,100);
rot_y = zeros(3,100);
rot_z = zeros(3,100);
trn_x = zeros(3,100);
trn_y = zeros(3,100);
trn_z = zeros(3,100);
rot_yz = zeros(3,100);
rot_xy_tr_z = zeros(3,100);

% Generate measurments
angles=-50:49;
for n=angles
    tic();
    angle=-2*pi*n/100;
    
    % Performe all transformations and measure
    Ir = img_rotate_3D( It, [angle, 0, 0],[0,0,0], 'nn');
    rot_x(1,n+51) = img_mse(Is, Ir);
    rot_x(2,n+51) = img_mi(Is, Ir);
    rot_x(3,n+51) = img_nmi(Is, Ir);
    
    Ir = img_rotate_3D( It, [0, angle, 0],[0,0,0], 'nn');
    rot_y(1,n+51) = img_mse(Is, Ir);
    rot_y(2,n+51) = img_mi(Is, Ir);
    rot_y(3,n+51) = img_nmi(Is, Ir);
    
    Ir = img_rotate_3D( It, [0, 0, angle],[0,0,0], 'nn');
    rot_z(1,n+51) = img_mse(Is, Ir);
    rot_z(2,n+51) = img_mi(Is, Ir);
    rot_z(3,n+51) = img_nmi(Is, Ir);
    
    Ir = img_rotate_3D( It, [0, 0, 0],[n,0,0], 'nn');
    trn_x(1,n+51) = img_mse(Is, Ir);
    trn_x(2,n+51) = img_mi(Is, Ir);
    trn_x(3,n+51) = img_nmi(Is, Ir);
    
    Ir = img_rotate_3D( It, [0, 0, 0],[0,n,0], 'nn');
    trn_y(1,n+51) = img_mse(Is, Ir);
    trn_y(2,n+51) = img_mi(Is, Ir);
    trn_y(3,n+51) = img_nmi(Is, Ir);
    
    Ir = img_rotate_3D( It, [0, 0, 0],[0,0,n], 'nn');
    trn_z(1,n+51) = img_mse(Is, Ir);
    trn_z(2,n+51) = img_mi(Is, Ir);
    trn_z(3,n+51) = img_nmi(Is, Ir);
    
    Ir = img_rotate_3D( It, [angle, angle, 0],[0,0,n], 'nn');
    rot_xy_tr_z(1,n+51) = img_mse(Is, Ir);
    rot_xy_tr_z(2,n+51) = img_mi(Is, Ir);
    rot_xy_tr_z(3,n+51) = img_nmi(Is, Ir);
    
    % Show time and progress
    disp(n);
    toc();
    pause(0.05);
end

save 3dResults.mat rot_x rot_y rot_z trn_x trn_y trn_z rot_xy_tr_z
