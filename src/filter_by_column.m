function [ Mx_out,My_out ] = filter_by_column( Mx_in,My_in)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for k = 1:size(Mx_in,2);
    p = polyfit(My_in(:,k),Mx_in(:,k),2);
    Mx_out(:,k) = polyval(p,My_in(:,k));
end
My_out = My_in;

end

