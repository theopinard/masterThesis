function [r] = norm_pixel(p1, p2, C);
%give the norm of two points using C as ponderation (C * (p1(1) - p2(:,1)).^2 + (p1(2) - p2(:,2)).^2).^0.5
%
    r = (C * (p1(1) - p2(:,1)).^2 + (p1(2) - p2(:,2)).^2).^0.5 ;
end