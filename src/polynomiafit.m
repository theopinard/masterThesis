function [ p,dist ] = polynomiafit( u, deg)
%[ p,dist ] = polynomiafit( u, deg) usig points in u and the degree deg of
%the polynomia give the best fit coefficient p and the dist from each
%points to the polinomia
%   Detailed explanation goes here

    x = u(:,1);
    y = u(:,2);
    
    p = polyfit(x,y,deg);
    yfit = polyval(p,x);
    yresid = y - yfit;
    
    SSresid = sum(yresid.^2);
    SStotal = (length(y)-1) * var(y);
    
    dist = abs(yresid);

end

