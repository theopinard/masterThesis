close all
clear all
clc

l = [1,2,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
path_output = '../output/step2/'
mkdir(path_output)
path_input = '../output/step1/chess_point_img'

for ii = 1:size(l,2)
points = load([path_input num2str(l(ii), '%02d') '.mat'])
center_in = points.centroids; % name to be changed
points_in = points.centroids2; % to be changed

[points,angle ] = sort_point( points_in, center_in, 30);
%points1 = points;
[points1] = deleteclosepoints(points, 2);
[points2,angle2] = sort_point(points1, center_in, 30);
[points3] = deletepoints( points2,angle2, 30, 5 );
[points4, angle4] = sort_point(points3, center_in, 30);

P = sort_column(points4, angle4, 40,10 );

P_f = fillMissingPoints(P)
ii

figure 
hold on
plot (points_in(:,1), points_in(:,2), '-r*');
for k=[1 length(points)];
    text(points_in(k,1), points_in(k,2),['  ' num2str(k)]);
end
%title('centroids2')

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_original']
saveas(gcf, path_to_fig, 'svg')
saveas(gcf, path_to_fig, 'jpeg')
figure 
hold on
plot (points(:,1), points(:,2), '-r*');
for k=[1 length(points)];
    text(points(k,1), points(k,2),['  ' num2str(k)]);
end
%title('points')

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_sort1']
saveas(gcf, path_to_fig, 'svg');
saveas(gcf, path_to_fig, 'jpeg');

figure 
hold on
plot (points1(:,1), points1(:,2), '-r*');
for k=[1 length(points1)];
    text(points1(k,1), points1(k,2),['  ' num2str(k)]);
end
%title('points1')

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_sort2'];
saveas(gcf, path_to_fig, 'svg');
saveas(gcf, path_to_fig, 'jpeg');

figure 
hold on
plot (points2(:,1), points2(:,2), '-r*');
for k=[1 length(points2)];
    text(points2(k,1), points2(k,2),['  ' num2str(k)]);
end
%title('points2')

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_sort3'];
saveas(gcf, path_to_fig, 'svg');
saveas(gcf, path_to_fig, 'jpeg');

figure
hold on
plot (points3(:,1), points3(:,2), '-r*');
for k=[1 length(points3)];
    text(points3(k,1), points3(k,2),['  ' num2str(k)]);
end
%title('points3')

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_sort4'];
saveas(gcf, path_to_fig, 'svg');
saveas(gcf, path_to_fig, 'jpeg');

figure
hold on
plot (points4(:,1), points4(:,2), '--r*');
for k=[1 length(points4)];
    text(points4(k,1), points4(k,2),['  ' num2str(k)]);
end

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_sort5'];
saveas(gcf, path_to_fig, 'svg');
saveas(gcf, path_to_fig, 'jpeg');

figure
plot(angle4, '-b*')

figure
hold on 
N = size(P,2);
for i = 1:N
    u = P{i};
    plot (u(:,1), u(:,2),'-*r')
    for k=[1 length(u)];
        text(u(k,1), u(k,2),['  ' num2str(k)]);
    end
end
hold on 
for i = 1:N 
    u = P_f{i};
    plot (u(:,1), u(:,2),'-*')
    for k=1:length(u); 
        text(u(k,1), u(k,2),['  ' num2str(k)]);
    end
end

set(gca,'YDir','reverse')
xlabel('\xi [px]');
ylabel('\eta [px]');
path_to_fig = [path_output int2str(ii) 'orderingPoints_sort_final'];
saveas(gcf, path_to_fig, 'svg');
saveas(gcf, path_to_fig, 'jpeg');


points_f{ii} = P_f;

close all
end

save([path_output 'agg_ordered_points.mat'], 'points_f')
