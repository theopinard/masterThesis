clear all
close all
clc

path_data = '../data/camera_root/'
path_output = '../output/'
listing = dir(fullfile( path_data, '*.tiff'));

list = {listing.name}
N = size(list,2);


for cell = list
image_name = cell{1}
image_path = [path_data image_name];
img_n = image_name(7:8)
% load image 
I1 = imread(image_path);
imshow(I1);

% crop image using the red circles
I2 = idCircle(I1); % identify the red circles
centroids = CircleCenter( I2, 20);
centroids = deleteclosepoints( centroids, 2);

% create mask
I3 = CreateMask(I1, centroids);

% converting to binary
I4 = im2bw(I3); 

% identify the chess corners from the image 
SE1 = strel('square',2); % structuring element is a 2x2 square
I4e = imerode(I4,SE1);	% erosion
I5 = identify_corner(I4,10);

I6 = maxmin(I5,0.6,0.4);
%I6 = maxmin(I5,0.75,0.25);

% create new mask to delete the most extreme value 
barycenter = mean(centroids);
x = centroids(:,1) * 0.9 + repmat(barycenter(1),4,1) * 0.1;
bary_centroids = [x centroids(:,2)];
I7 = logical(CreateMask(I6,bary_centroids));

centroids2 = CircleCenter( I7, 10);

% delete the first point which is middle of the black area
centroids2 = centroids2(2:end,:);  


% save centroids
centroid_path = [path_output 'intermediary_result/chess_point_img' img_n '.mat'];

save(centroid_path, 'centroids','centroids2')

%%
path_image = [path_output 'image/img' img_n]
for i=1:7
    imshow(eval(['I'  num2str(i)]));
    imwrite(eval(['I'  num2str(i)]),[path_image 'step' num2str(i) '.jpg'], 'jpg');
    print(gcf,'-depsc2 ', [path_image 'step' num2str(i) '.eps'])
end

imshow(I1)
hold on
plot(centroids2(:,1), centroids2(:,2), 'or', 'Markersize', 10)
imwrite(eval(['I'  num2str(i)]),[path_image 'step' num2str(i+1) '.jpg'], 'jpg')
print(gcf,'-depsc2 ', [path_image 'step' num2str(i+1) '.eps'])
close all

end