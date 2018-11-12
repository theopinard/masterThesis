function [ points_out ] = deletepoints( points_in,angle, alpha, N )
% delete the N isolated point set using the angle vector and the alpha
% value
%   
points_out = points_in;
line = (angle > alpha) & (angle < 360 - alpha);
u = find(line);
diffu = diff(u);

for i = length(diffu):-1:1;
    if diffu(i) < N;
        points_out = [points_out(1:u(i)-1,:); points_out(u(i+1):end,:)];
       
    end   
end

end

