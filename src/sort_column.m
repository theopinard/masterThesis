function [ P2 ] = sort_column(points_in,angle_in ,alpha, p_cut )
% ordered points_in by columns using angle_in and alpha 
%   Detailed explanation goes here

N = size(points_in);

j = 1;
u(1,:) = points_in(1,:);
for i = 2:N(1)
    temp = angle_in(i); 
    %[i, temp , (temp > alpha & temp < 360-alpha)]
    if (temp > alpha & temp < 360-alpha);
        x_mean(j) = mean(u(:,1));
        P{j}= u;
        j = j + 1;
        u = [];
    end
    
    u_s = size(u);
    u(u_s(1)+1,:) = points_in(i,:);  
end
x_mean(j) = mean(u(:,1));
P{j}= u;


for i = 1:j
    u = P{i};
    v(i) = mean(u(:,1));        
end
[B,I] = sort(v);


inc = 1; 
for i = 1:j
    u = P{I(i)};
    if size(u,1) > p_cut;
        u = sortrows(u,-2);
        P2{inc} = u;
        inc = inc + 1;
    end
    
end


end

