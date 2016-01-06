% Read two images
Imoving=im2double(imread('images/lenag2.png'));
Istatic=im2double(imread('images/lenag3.png'));

% Use mutual information
Options.Similarity='sd';
Options.Registration = 'Affine';
Options.MaxRef = 1;
Options.Verbose = 2;
Ireg = image_registration(Imoving,Istatic,Options);

% Show the registration result
figure,
subplot(2,2,1), imshow(Imoving); title('moving image');
subplot(2,2,2), imshow(Istatic); title('static image');
subplot(2,2,3), imshow(Ireg); title('registerd moving image');