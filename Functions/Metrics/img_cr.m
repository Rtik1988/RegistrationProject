function [ cr ] = img_cr( Ia, Ib )
%IMG_CR Roche correlation ratio
%   IMG_C(Ia,Ib) Calculates correlation ratio between image Ia and Ib.
%
%   Arguments:
%       Ia,Ib - Images to compare
%   Output:
%       cr - Correlation ratio between the images
%
%   Written by Atriom Lapshin 2016

% Check input validity
lenA = numel(Ia);
lenB = numel(Ib);
cr = 0;
if lenA ~= lenB 
    disp('img_mse: not the same length');
    return;
end

% Calculate Ib variance and mean
N = lenA;
miu = (1/N)*sum(Ib(:));
sig = (1/N)*sum(Ib(:).^2) - miu^2;

% Calculate variance and mean of each pixel combination
acc = 0;
for i=0:255
    Omega_i = Ia(:)==i;
    N_i = sum(Omega_i);
    if N_i == 0
        continue
    end
    
    Ib_i = Ib(Omega_i);
    miu_i = (1/N_i)*sum(Ib_i);
    sig_i = (1/N_i)*sum(Ib_i.^2) - miu_i^2;
    
    acc = acc + N_i*sig_i;
end

% Get final result
cr = (1/(N*sig))*acc;

end

