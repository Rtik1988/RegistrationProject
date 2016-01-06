
Is = imread('prostate1.png');
Spacing=[20,100];
O=make_init_grid(Spacing,[size(Is,1) size(Is,2)]);
[O_trans,Spacing]=refine_grid(O_trans,Spacing,size(Imoving));
O(6,6,1)=10000;
tic;
for i=1:100
[Ib,Tx,Ty]=bspline_transform_2d_double(double(O(:,:,1)),double(O(:,:,2)),Is,double(Spacing(1)),double(Spacing(2)),double(1));
end
toc;

figure;
subplot(1,2,1);
imagesc(Is);
subplot(1,2,2);
imagesc(Ib);

% Building grid and refining
Spacing=[150 150];
O_trans=make_init_grid(Spacing,[size(Is,1) size(Is,2)]);
I1=bspline_transform_2d_double(double(O_trans(:,:,1)),double(O_trans(:,:,2)),Is,double(Spacing(1)),double(Spacing(2)),double(1));
[O_trans,Spacing]=refine_grid(O_trans,Spacing,size(Is));
I2=bspline_transform_2d_double(double(O_trans(:,:,1)),double(O_trans(:,:,2)),Is,double(Spacing(1)),double(Spacing(2)),double(1));
figure, imagesc(abs(I1-I2)),colorbar;