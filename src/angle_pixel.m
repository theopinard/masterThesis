function [ angle] = angle_pixel( p1,p2 );
%angle_pixel give the angle in degree of the line (p1,p2) with vertical line 
%   
%angle = atand((p1(1,1) - p2(1,1))  / (p1(1,2) - ...
%    p2(1,2)));
x1 = 0;
y1 = 1;
x2 = p1(1,1) - p2(1,1);
y2 = p1(1,2) - p2(1,2);
angle = atan2d_linux(x1*y2-y1*x2,x1*x2+y1*y2);
end

