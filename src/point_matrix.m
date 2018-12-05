function [ Mx,My,Weight ] = point_matrix( P_in )
%from P_in create Mx, My and Wheight  
%   
n = length(P_in);
m = length(P_in{1});

Mx = zeros(m,n);
My = zeros(m,n);
Weight = ones(m,n);

for j = 1:n;
    u = P_in{j};
    for i = 1:m;
        Mx(i,j) = u(i,1);
        My(i,j) = u(i,2);
    end
end

end

