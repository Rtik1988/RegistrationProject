function [ result ] = joint_hist_3D( Ia, Ib )
%JOINT_HIST_3D  Joint histogram of 2 images.
%   JOINT_HIST_3D(Ia,Ib) Calculated the joint histogram between 2 images
%
%   Arguments:
%       Ia,Ib - Images to compare
%   Output:
%       result - Joint histogram matrix
%
%   Written by Atriom Lapshin 2016

size_a = size(Ia);
size_b = size(Ib);
result = zeros(256,256,size(Ia,4));

Ia_r = round(Ia);
Ib_r = round(Ib);

if sum(size_a-size_b)
    disp('Size doesnt match');
    return;
end

for l=1:size(Ia,4)
    for n=1:size_a(1)
        for m=1:size_a(2)
            for k=1:size_a(3)
                result(Ia_r(n,m,k,l)+1, Ib_r(n,m,k,l)+1, l) = result(Ia_r(n,m,k,l)+1, Ib_r(n,m,k,l)+1, l) + 1;
            end
        end
    end
end

result = result./(size_a(1)*size_a(2)*size_a(3)*size(Ia,4));

end

