function [ d ] = distance2line_pixel(V, Q1,Q2)
%give the distance of points in V to the line (Q1,Q2)
%   Detailed explanation goes here
N = size(V);
for i = 1:N(1)
    d(i) = abs(det([Q2'-Q1',V(i,:)'-Q1']))/norm(Q2-Q1);
end
end

