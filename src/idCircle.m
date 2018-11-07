function [ I_out ] = idCircle( I_in)
%idCircle from a 
% Identification of red circles

% creating a new matrix to get the red circle in white and the rest in
% black
I2 = I_in(:,:,1) - 0.5 * I_in(:,:,2) - 0.5 * I_in(:,:,3);
I_out = I2 > 10 * mean(mean(I2));

%figure; imshow(I_out)
end

