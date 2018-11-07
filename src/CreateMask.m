function [ I_out ] = CreateMask( I_in, centroids )
%Create mask to cover all the background
%   Detailed explanation goes here
c = centroids(:,1);
r = centroids(:,2);
I_mask = roipoly(I_in,c,r);
for col = 1:size(I_in,3);
    I_out(:,:,col) = uint8(I_in(:,:,col)) .* uint8(I_mask);
end


end

