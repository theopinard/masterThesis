function [ I_out ] = maxminvalue( I_in, max1, min1 )
% ( I_in > ( max1) ) | (I_in < (min1) )
%   Detailed explanation goes here
A = max(max(I_in));
I_out = ( I_in > ( max1 * A) ) | (I_in < (min1 * A) );

end

