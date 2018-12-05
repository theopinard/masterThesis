function [ Mx_out,My_out,Mz_out ] = inverseproblem( Mx_in,My_in,Weight_in, h, Z0,y_c,z_c)
% from the projection points with the coordinate Mx My and the Weight for each point
% h is the distance between the first captured by the camera and the origin
% h = 16 * 5 mm
%Z0 is the height of the first captured point by the camera
% alpha0 is the angle of the plate at the first point and the projection point. 
%   Detailed explanation goes here
[m,n] = size(Weight_in);



Mx_out = zeros(m,n);
My_out = zeros(m,n);
Mz_out = zeros(m,n); 

Mx_out(1,:) = 15 * (1:n);
My_out(1,:) = h;
Mz_out(1,:) = Z0 * ones(1,n); 

for i = 2:m;
    
    scale1 = mean(diff(Mx_in(i,:)));
    scale2 = mean(diff(Mx_in(i-1,:)));
    scale = (scale1 + scale2) / 2;
    
    for j = 1:n;
        p1 = [Mx_in(i,j), My_in(i,j)];
        p2 = [Mx_in(i-1,j), My_in(i-1,j)];
        di = norm_pixel(p1,p2,1) / scale;
        %di = (My_in(i-1,j) - My_in(i,j)) / scale;
        
        alpha(i-1) = asin(di);
        
        %alpha_eff = alpha - alpha0;% - alpha_init;
        alpha_c = atan((z_c-Mz_out(i-1,j))/(My_out(i-1,j) - y_c));
        alpha_eff(i-1) = alpha(i-1) - alpha_c;
%         if i ==2
%             coeff(j) = alpha1 / alpha_eff;
%         end
%         alpha_eff = alpha_eff * coeff(j);
        Mx_out(i,j) = Mx_out(i-1,j);
        My_out(i,j) = My_out(i-1,j) + 15 * cos(alpha_eff(i-1));
        Mz_out(i,j) = Mz_out(i-1,j) + 15 * sin(alpha_eff(i-1));
    end
    
end
% figure
% plot(alpha_eff*180/pi)


end

