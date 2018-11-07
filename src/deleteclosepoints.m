function [ points_out ] = deleteclosepoints( points_in, fact)
% delete points 
% 
n = 2;

dmin = zeros(size(points_in,1),1);
for i = 1:size(points_in,1);
    d = norm_pixel(points_in(i,:), points_in, 1);
    d1 = sort(d);
    v_min = d1(2:1+n);
    dmin(i) = mean(v_min);
end

dmean = mean(dmin);
points_out = points_in;
i = 1; 
while i <= size(points_out,1);
    d = norm_pixel(points_out(i,:), points_out, 1);
    d1 = sort(d);
    v_min = d1(2);
    dmean = dmin(i);
    if v_min < dmean / fact; 
        a = d < (dmean / fact);
        points_to_group = points_out(a,:); 
        points_out(i,:) = mean(points_to_group);
        b = ~a;
        b(i) = 1;
        points_out = points_out(b,:);
        dmin = dmin(b);
    end
    i = i+1;
        
        
end
end




