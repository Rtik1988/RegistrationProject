close all;

Is = imread('Is.png');
Is = double(Is);
Ip = double(Is);
%Ip = img_to_gmm_2D(double(Is), 3);
res=[];
for angle=-pi/2:0.01:pi/2
    T=[cos(angle),-sin(angle),0;sin(angle),cos(angle),0;0,0,1];
    Itemp = img_affine_transform( Ip, T, 'bil' );
    res = [res img_distance(Ip,Itemp,'mi',0)];
    disp(angle);
end

plot(res);