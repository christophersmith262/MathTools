%
% newtonInterpolation(points, DD=dividedDifference(points))
%
% By: Christopher Smith
%
% Usage: f = newtonInterpolation([0, 1; 2,3; 4,5])
%
% Description:
%
%    Generates a polynomial fit for the input points
%    using the Newton Interpolation method.
%
% Arguments:
%
%    points: A n x 2 matrix of x,y pairs (x in the first
%            column, y in the second column where n is the
%            number of points in question.
%
% Returns:
%
%    f: The least degree polynomial passing through the
%       input points.
%
function [ f ] = newtonInterpolation( points, DD )
    syms x;
    
    % this allows the dd matrix to be calculated elsewhere
    % for display/debugging purposes.
    if nargin < 2,
        DD = dividedDifference(points);
    end
    
    % the number of points the polynomial
    % must pass through
    n = length(DD);
    
    % generate the polynomial
    f = 0;
    p = 1;
    for i=1:n,
        f = f + DD(i,i) * p;
        p = p * (x - points(i, 1));
    end
end

