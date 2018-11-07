function [ centroids ] = CircleCenter( I_in ,f)
%find the circle center in the matrix I_in. f is the size of the circle you are looking for. 
%   Detailed explanation goes here

% create average filter using f
h = fspecial('average', [f f]);
I5 = imfilter(double(I_in),h);
I6 = logical(I5 > 0.5);

% find the circle 
s = regionprops(I6, 'centroid');
centroids = cat(1, s.Centroid);


% figure;
% imshow(I6)
% hold on
% plot(centroids(:,1), centroids(:,2), 'r*')

end

