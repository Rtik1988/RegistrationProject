function [ result ] = joint_hist( Ia, Ib )
%JOINT_HIST  Joint histogram of 2 images.
%   JOINT_HIST(Ia,Ib) Calculated the joint histogram between 2 images
%
%   Arguments:
%       Ia,Ib - Images to compare
%   Output:
%       result - Joint histogram matrix
%
%   Written by Atriom Lapshin 2016

size_a = size(Ia);
size_b = size(Ib);
result = zeros(256,256,size(Ia,3));

Ia_r = round(Ia);
Ib_r = round(Ib);

if sum(size_a-size_b)
    disp('Size doesnt match');
    return;
end

for k=1:size(Ia,3)
    for n=1:size_a(1)
        for m=1:size_a(2)
            result(Ia_r(n,m,k)+1, Ib_r(n,m,k)+1, k) = result(Ia_r(n,m,k)+1, Ib_r(n,m,k)+1, k) + 1;
        end
    end
end

% total = (asizex*asizey) - sum(result(1,:)) - sum(result(:,1)) + result(1,1);
% result = result(2:end,2:end)./total;
result = result./(size_a(1)*size_a(2)*size(Ia,3));

end

