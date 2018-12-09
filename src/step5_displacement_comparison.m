clear all
close all
clc

load('../output/step2/agg_ordered_points.mat');
load('../output/step4/back_camera_filtered_control_point.mat');
path_output = '../output/step5/'
mkdir(path_output)
R1 = [291,291,300,300,294,294,285,285,242,242,230,230,215,215,172,172];
R2 = [272,272,282,282,274,274,265,265,221,221,207,207,195,195,150,150];

h = 15 * 16 ;
Z0 = 0;
y_c = -30;
z_c = 125;


alpha1 = zeros(size(points_f,2),1);


for i = 1:size(points_f,2)
    P = points_f{i};
    P2 = points_camera2{i};
    
    [ Mx,My,Weight ] = point_matrix( P );
    [ Mx,My ] = filter_by_column( Mx,My);
    [ Mx,My ] = filter_by_row( Mx,My);
    
    
    % find the angle 
    p2 = polyfit(P2(:,1),P2(:,2),3);
    Dp2 = polyder(p2);
    alpha1(i) = atan(polyval(Dp2,h));
    Z0(i) = polyval(p2,h);
    
    
    [ Mx_out,My_out,Mz_out ] = inverseproblem( Mx,My,Weight, h, Z0(i),y_c,z_c);
    
    
    

    x = Mx_out(end,:);
    z = Mz_out(end,:);
    p = polyfit(x,z,1);
%     R1_image(i) = 1 * Mz_out(end,end);
%     R2_image(i) = 1 * Mz_out(end,1);
    R1_image(i) = polyval(p,x(end)+ 3*15);
    R2_image(i) = polyval(p,x(1) - 2*15);
    R1_camera2(i) = P2(end,2);
    
    R1_image_perfil{i} = [My_out(:,end),Mz_out(:,end)];
end




R1 = R1 - R1(end);
R2 = R2 - R2(end);
R1_image = R1_image - R1_image(end);
R2_image = R2_image - R2_image(end);
R1_camera2 = R1_camera2 - R1_camera2(end);

ind_cal = 3;
factor1 = (2 * R1(ind_cal))/(R1_image(ind_cal)+R1_image(ind_cal + 1))
factor2 = (2 * R2(ind_cal))/(R2_image(ind_cal)+R2_image(ind_cal + 1))
%factor =  0.5 * (factor1 + factor2);
figure(1)
subplot(1,2,1)
hold on 
plot((R1))
plot(R1_image*factor1,'r')
plot(R1_camera2,'*k')
legend('mesured','image processing camera1','image processing camera2')
title('R1')

subplot(1,2,2)
hold on 
plot(R2)
plot(R2_image*factor2,'r')
plot(R1_camera2,'*k')
legend('mesured','image processing camera1','image processing camera2')
title('R2')

error1 = (abs(R1 - R1_image*factor1))
error2 = (abs(R2 - R2_image*factor2))

M = [R1', R1_image'*factor1,error1',R2', R2_image'*factor2,error2'];

M(end-1:end,:) = [];
M(ind_cal:ind_cal+1,:) =[];

for k = 1:size(M,2)
    M1(k,:) = 0.5+M(2*(k-1)+1,:) + 0.5 * M(2*k,:);
end
M1;
e1 = sum(M1(:,3))
e2 = sum(M1(:,6))
rowLabels = {'case 1', 'case 2','case 3', 'case 4','case 5', 'case 6'};
columnLabels = {'displacement measured', 'displacement estimated [mm]', 'absolute error [mm]'};
matrix2latex(M1(:,1:3), [path_output 'out1.txt'], 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f');
matrix2latex(M1(:,4:6), [path_output 'out2.txt'], 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f');

columnLabels = {'displacement measured at corner 1', 'displacement estimated at corner 1 [mm]', 'absolute error at corner 1 [mm]'...
    'displacement measured at corner 2', 'displacement estimated at corner 2 [mm]', 'absolute error at corner 2 [mm]'};
matrix2latex(M1, [path_output 'out.txt'], 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f','size','tiny');
%%
k = 1;
for i = [1 3 4 5 6 7];
    
    P1 = (R1_image_perfil{2*(i-1)+1} + R1_image_perfil{2*(i)}) / 2;
    P2 = (points_camera2{2*(i-1)+1} + points_camera2{2*(i)}) /2;
    
    
    %set(gca,'fontsize',22)
   
    error = max(abs(interp1(P2(:,1),P2(:,2),P1(:,1))-P1(:,2)));
    figure
    grid
    set(gca,'fontsize',22,'GridLineStyle','-', ...
    'YColor',[0.3 0.3 0.3],...
    'XColor',[0.3 0.3 0.3])

    xlabel('y [mm]')
    ylabel('z [mm]')
    hold on
    
    plot(P2(:,1), P2(:,2),'-ob','MarkerFaceColor','b','Linewidth', 2.0)
    plot(P1(:,1), P1(:,2),'-vr','MarkerFaceColor','r','Linewidth', 2.0)
    legend('measured from camera 2','image processing','location','NorthWest')
    name = ['case ' , num2str(k)];
    title([name,' with maximum error = ' ,num2str(error), ' mm'])
    set(gcf, 'Position', [0, 0, 5000, 1000])
    saveas(gcf,[path_output 'case' num2str(k) 'without_cal'], 'jpeg')
    
    
%     figure , grid
%     hold on
%     plot(P2(1:end-1,1), diff(P2(:,2))./diff(P2(:,1)),'b')
%     plot(P1(1:end-1,1), diff(P1(:,2))./diff(P1(:,1)),'r')
%     name = ['case ' , num2str(k)];
%     title([name ' with alpha1 =' num2str(180/pi * (alpha1(2*i)))])
    k = k+1;
    
end


%%
k = 1;
ind_cal1 = 3;
ind_cal2 = 15;

z1 = 0.5 *points_camera2{ind_cal1}(end,2) + 0.5*points_camera2{ind_cal1+1}(end,2);
z2 = 0.5 *points_camera2{ind_cal2}(end,2) + 0.5*points_camera2{ind_cal2+1}(end,2);

z1ip = 0.5*R1_image_perfil{ind_cal1}(end,2) + 0.5*R1_image_perfil{ind_cal1+1}(end,2);
z2ip = 0.5*R1_image_perfil{ind_cal2}(end,2) + 0.5*R1_image_perfil{ind_cal2+1}(end,2);

a = (z2-z1) / (z2ip - z1ip);
b = z1 - z1ip *a;

%factor = 1 + (linspace(0,1,size(R1_image_perfil{1},1))') *((points_camera2{ind_cal}(end,2) + points_camera2{ind_cal+1}(end,2)) / (R1_image_perfil{ind_cal}(end,2) + R1_image_perfil{ind_cal+1}(end,2))-1);
t = (linspace(0,1,size(R1_image_perfil{1},1))').^2;
    
for i = [1 3 4 5 6 7];
    
    P1 = (R1_image_perfil{2*(i-1)+1} + R1_image_perfil{2*(i)}) / 2;
    P2 = (points_camera2{2*(i-1)+1} + points_camera2{2*(i)}) /2;
    
    
    P1(:,2) = P1(:,2) .*(1 + t * (a-1))+ t*b;
    %set(gca,'fontsize',22)
   
    error = max(abs(interp1(P2(:,1),P2(:,2),P1(:,1))-P1(:,2)));
    figure
    grid
    set(gca,'fontsize',22,'GridLineStyle','-', ...
    'YColor',[0.3 0.3 0.3],...
    'XColor',[0.3 0.3 0.3])

    xlabel('y [mm]')
    ylabel('z [mm]')
    hold on
    
    plot(P2(:,1), P2(:,2),'-ob','MarkerFaceColor','b','Linewidth', 2.0)
    plot(P1(:,1), P1(:,2),'-vr','MarkerFaceColor','r','Linewidth', 2.0)
    legend('measured from camera 2','image processing','location','NorthWest')
    name = ['case ' , num2str(k)];
    title([name,' with maximum error = ' ,num2str(error), ' mm'])
    set(gcf, 'Position', [0, 0, 5000, 1000])
    saveas(gcf, [path_output 'case' num2str(k) 'tip_cal'], 'jpeg')
    
    
%     figure , grid
%     hold on
%     plot(P2(1:end-1,1), diff(P2(:,2))./diff(P2(:,1)),'b')
%     plot(P1(1:end-1,1), diff(P1(:,2))./diff(P1(:,1)),'r')
%     name = ['case ' , num2str(k)];
%     title([name ' with alpha1 =' num2str(180/pi * (alpha1(2*i)))])
    k = k+1;
end


%%

shift_R1 = R1_image_perfil{end}(:,2);
shift_camera2 = points_camera2{end}(:,2);
p_shift = polyfit(points_camera2{end}(:,1),points_camera2{end}(:,2),3);

for i = 1:size(points_f,2)
    R1_image_perfil{i}(:,2) = R1_image_perfil{i}(:,2) - R1_image_perfil{end}(:,2);
    points_camera2{i}(:,2) = points_camera2{i}(:,2) - points_camera2{end}(:,2);    
end

p = polyfit(points_camera2{ind_cal}(:,1),points_camera2{ind_cal}(:,2),3);
factor = 2 * polyval(p,R1_image_perfil{ind_cal}(:,1)) ./ (R1_image_perfil{ind_cal}(:,2) + R1_image_perfil{ind_cal+1}(:,2));

k = 1
for i = [1 3 4 5 6 7]
    P1 = (R1_image_perfil{2*(i-1)+1} + R1_image_perfil{2*(i)}) / 2;
    P2 = (points_camera2{2*(i-1)+1} + points_camera2{2*(i)}) /2;
    
    P2(:,2) = P2(:,2) + shift_camera2;
    P1 (:,2) = P1(:,2) .* factor + polyval(p_shift,P1(:,1));
    
    error = max(abs(interp1(P2(:,1),P2(:,2),P1(:,1))-P1(:,2)));
    
    figure
    grid
    set(gca,'fontsize',22,'GridLineStyle','-', ...
    'YColor',[0.3 0.3 0.3],...
    'XColor',[0.3 0.3 0.3])

    xlabel('y [mm]')
    ylabel('z [mm]')
    hold on
    
    plot(P2(:,1), P2(:,2),'-ob','MarkerFaceColor','b','Linewidth', 2.0)
    plot(P1(:,1), P1(:,2),'-vr','MarkerFaceColor','r','Linewidth', 2.0)
    legend('measured from camera 2','image processing','location','NorthWest')
    name = ['case ' , num2str(k)];
    title([name,' with maximum error = ' ,num2str(error), ' mm'])
    set(gcf, 'Position', [0, 0, 5000, 1000])
    saveas(gcf ,[path_output 'case' num2str(k) 'full_cal'], 'jpeg')
    
    k = k+1;
end

close all

