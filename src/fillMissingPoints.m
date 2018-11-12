function [ P ] = fillMissingPoints( P_in )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
P = P_in;
N = size(P,2);
for i = 1:N
    u = P{i};
    s(i) = size(u,1);
end


for k = 1:max(s)
    
    
    line = extract_line( k, P );
    [p,dist] = polynomiafit( line, 1);
    
    limit = 5;
    while (sum(dist > limit))>=1;
    %if (sum(dist > limit))>=1;
        [~,ind]=max(dist);
        [k ind]
        
        %ind = find(dist >limit);
        line(ind,:) = [];
        p_new = polynomiafit( line, 1);
        
        u_col = P{ind};
        
        % try to find a point which fit in the col u_col
        dist_col = abs(polyval(p_new,u_col(:,1)) - u_col(:,2));
        if dist_col < 1;
            point_toreplace = u_col(dist_col < 1,:);
            u_new = u_new(dist_col > 2,:);
            u_new = [u_col(1:k-1,:); point_toreplace ; u_col(k:end,:)];
            
        else
            p_col = polynomiafit(u_col, 3);
            temp = [0 0 p_new];
            polos = roots(p_col - temp); 

            [~,ind2] = min(abs(polos - mean(u_col(:,1))));

            x_toreplace = polos(ind2);
            y_toreplace = polyval(p_new,x_toreplace);

            %u = P{ind};
            u1 = u_col(1:k-1,:);
            point_toreplace = [x_toreplace y_toreplace];
            u2 = u_col(k:end,:);
            u2 = u2(u2(:,2)<y_toreplace,:);
            u_new = [u1;point_toreplace;u2];
            
            P{ind} = u_new;
        end
        line = extract_line( k, P );
        [p,dist] = polynomiafit( line, 1);
    end
    
    
end

end

