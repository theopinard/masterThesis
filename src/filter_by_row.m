function [ Mx_out,My_out ] = filter_by_row( Mx_in,My_in)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for k = 1:size(Mx_in,1)
    p = polyfit(Mx_in(k,:),My_in(k,:),1);
    My_out(k,:) = polyval(p,Mx_in(k,:));
end
Mx_out = Mx_in;


end

