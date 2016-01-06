%clear all;
%close all;

res=zeros(3,101);
It = imread('It.png');
[sizey sizex] = size(It);
Ip = img_to_gmm_2D(double(It), 3);

for i=-50:50
    res(1,i+51)=i;
    
%     % Rotate
%     angle=2*pi*i/100;
%     Ir = double(img_rotate_2D(Ip, angle, 'bil'));
%     res(2,i+51)=img_nc(Ir,Ip);
%     % Translate X
%     
%     T = [1, 0, sizex*i/100; ...
%          0, 1, 0; ...
%          0, 0, 1];
%     Ir = double(transform_img_2(Ip, T, 'bil'));
%     res(3,i+51)=img_nc(Ir,Ip); 
%     
%     % Translate Y
%     T = [1, 0, 0; ...
%          0, 1, sizey*i/100; ...
%          0, 0, 1];
%     Ir = double(transform_img_2(Ip, T, 'bil'));
%     res(4,i+51)=img_nc(Ir,Ip); 
    
    % Scale X
    T = [1+0.2*i/100, 0, 0; ...
         0, 1, 0; ...
         0, 0, 1];
    Ir = double(transform_img_2(Ip, T, 'bil'));
    res(2,i+51)=img_nc(Ir,Ip); 
    
    % Translate Y
    T = [1, 0, 0; ...
         0, 1+0.2*i/100, 0; ...
         0, 0, 1];
    Ir = double(transform_img_2(Ip, T, 'bil'));
    res(3,i+51)=img_nc(Ir,Ip); 
    
    disp(i);
end



plot(res(1,:),res(2,:),res(1,:),res(3,:));
title('Normalized correlation under rotation');
legend('X Scaling', 'Y Scaling');
xlabel('Percent');
ylabel('Normalized correlation');