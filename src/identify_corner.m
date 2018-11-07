function I_out = identify_corner(I_in, scale)
%IDENTIFY_CORNER identify the chess corner in a image
%   Detailed explanation goes here

scale = int32(scale);
%normalisation of I_in
I_in = double(I_in) / max(max(double(I_in)));

% creation of the mask using the number scale 
mask1 = double([-ones(scale), ones(scale); ones(scale), -ones(scale)]);

%mask1 =    |-1  1|
%           |1  -1|
mask2 = double([zeros(scale),ones(scale);  ones(scale),zeros(scale)]);
%mask2 =    |0  1|
%           |1  0|
%calculation of I_out
I_out = double(zeros(size(I_in)));

for i=scale:size(I_in,1)-scale
    %disp([num2str(i) ' / ' num2str(size(I_in,1)-scale)]);
    for j=scale:size(I_in,2)-scale
         temp = (mask2 - I_in(i-scale+1:i+scale, j-scale+1:j+scale)) .* mask1;
        I_out(i,j) = sum(sum(temp)) / (4*double(scale)^2);
    end
end
    
end

