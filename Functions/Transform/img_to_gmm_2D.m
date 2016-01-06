function [ Ip, GMModel ] = img_to_gmm_2D( I, k, GMModel )
%IMG_TO_GMM Transform image into GMM k probability maps. If existing GMM is
%   proveded it will be used, otherwise it will be estimated.
%
%   Arguments:
%       I - Source image
%       k - The order of GMM
%       GMModel - Gaussian mixture model of the image
%   Output:
%       Ip - The resulting probability mapped image
%       GMModel - The GMM that was used
%
%   Written by Atriom Lapshin 2016

% Store size
[sizey,sizex] = size(I);

% Ignore pixels with the value of 0
Inz=I(I~=0);

if nargin < 3
    % Generate GM Model
    options = statset('MaxIter',1000);
    GMModel = fitgmdist(Inz,k,'Options',options);
end

% Order the gaussians
[mu, index] = sort(GMModel.mu);
OrderedGMModel = gmdistribution(GMModel.mu(index),GMModel.Sigma(index),GMModel.PComponents(index));

% Build probability maps
Ip = double(round(255.*posterior(OrderedGMModel,I(:))));
Ip = reshape(Ip,sizey,sizex,3).*repmat(double(I~=0),1,1,3);

end

