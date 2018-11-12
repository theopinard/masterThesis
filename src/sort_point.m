function [points_out,angle ] = sort_point( centroids2, centroids, alpha );
%Sort points by line givein addition the angle 
%   Detailed explanation goes here
C = 10;

d = norm_pixel(centroids(1,:), centroids2, C);
[v_min,ind] = min(d);
p_next = centroids2(ind,:);
points_out(1,:) = p_next;
centroids2 = centroids2([1:ind-1,ind+1:end],:);
angle = [0];
for i = 1:(length(centroids2));
    
    %find the nearest from p-next 
    d = norm_pixel(p_next, centroids2, C);
    [v_min,ind] = min(d);
    
    % if the point is not on the same line 
    angle(end+1) = (angle_pixel(p_next,centroids2(ind,:)));
    temp = angle_pixel(p_next,centroids2(ind,:));
    if temp > alpha & temp < 360-alpha;
        
        % find the point nearest from the line and the point
        Q2 = centroids(4,:);
        Q1 = centroids(1,:);
        d = distance2line_pixel(centroids2, Q1,Q2)' + 0.1 * norm_pixel(centroids(1,:),centroids2,C);
        %p_next = centroids(1,:);
        [v_min,ind] = min(d);
        angle(end) = angle_pixel(p_next,centroids2(ind,:));
    end
    p_next = centroids2(ind,:);
    points_out(end+1,:) = centroids2(ind,:);
    centroids2 = centroids2([1:ind-1,ind+1:end],:);
end

end

