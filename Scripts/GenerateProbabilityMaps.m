clear all;
close all;

% Load the data
ni=load_nii('case2');
vox=double(ni.img);
vox=vox(vox~=0);

% Generate GM Model
options = statset('MaxIter',1000);
GMModel = fitgmdist(vox,3,'Options',options);

% Show the model
%ezplot(@(x)pdf(GMModel,x),[1 255]);

% Transform slice into probability values
slice = ni.img(:,:,60);
[sizey,sizex] = size(slice);
pslice = posterior(GMModel,slice(:));
pslice = reshape(pslice,sizey,sizex,3).*repmat(double(slice~=0),1,1,3);

% Display probabilities
figure;
for i=1:3
    subplot(1,3,i);
    imagesc(pslice(:,:,i));
end

%nc = sum(reshape(a.*b,1,numel(a)))/sqrt(sum(reshape(a.*a,1,numel(a)))*sum(reshape(b.*b,1,numel(a))));
