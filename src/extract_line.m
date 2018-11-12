function [ line ] = extract_line( k, P )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = size(P,2);
for i = 1:N;
    u = P{i};
    if k <= size(u,1)
        line(i,:) = u(k,:);
    else
        line(i,:) = u(end,:);
    end
        
end

end

