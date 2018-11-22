close all
clear all
clc
figure
set(gca,'fontsize',18)
hold on
grid
xlabel('y')
ylabel('z')

load('../output/back_camera_control_point.mat')
k = 1
for i = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 20 21]
    i
    A = results(i).displacement;
    B = A;
    [p,dist] = polynomiafit(B, 3);
    limit = 2 * results(i).scale;
    
    while (sum(dist > limit))>=1;
        [~,ind]=max(dist);
        %ind = dist > limit;
        ind;
        B_temp = B;
        B_temp(ind,:) = [];
        p_new = polynomiafit( B_temp, 3);
        B(ind,2) = polyval(p_new,B(ind,1));
        [p,dist] = polynomiafit( B, 3);
    end
    plot(A(:,1),-A(:,2),'or',B(:,1),-B(:,2),'b')
    points_camera2{k} = [B(:,1), -B(:,2)] * 747 / 717;
    k = k+1;
end
set(gcf, 'Position', [0, 0, 5000, 1000])

legend('estimated displacement  from the camera 2','filtered displacement using polinomial fit','location','NorthWest')

saveas(gcf, ['../output/camera_control/displacement_sum_up'], 'jpeg')

save('../output/back_camera_filtered_control_point.mat', 'points_camera2')
