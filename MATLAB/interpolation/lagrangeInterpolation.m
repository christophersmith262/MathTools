%
% lagrangeInterpolation(points, debug=false)
%
% By: Christopher Smith
%
% Usage: f = lagrangeInterpolation([0, 1; 2,3; 4,5])
%
% Description:
%
%    Generates a polynomial fit for the input points
%    using the Lagrange Interpolation method.
%
% Arguments:
%
%    points: A n x 2 matrix of x,y pairs (x in the first
%            column, y in the second column where n is the
%            number of points in question.
%    debug: set to true to print debug info including the
%           Lagrange functions used in the calculation.
%
% Returns:
%
%    f: The least degree polynomial passing through the
%       input points.
%
function [ f ] = lagrangeInterpolation( points, debug )
    syms x;
    n = length(points);
    f = 0;
    
    if nargin < 2,
        debug = false;
    end
    
    if debug,
        fprintf('\tDEBUG: lagrangeInterpolation(\n');
        fprintf('  [\n');
        disp(points);
        fprintf('  ], %d)\n', debug);
    end
    
    for i=1:n,
        numer = 1;
        denom = 1;
        for j=1:n,
            if j ~= i,
                numer = numer * (x - points(j, 1));
                denom = denom * (points(i, 1) - points(j,1));
            end
        end
        if debug,
            fprintf('\tDEBUG: L_%d = %s\n', i, char(numer/denom));
        end
        f = f + (numer / denom) * points(i,2);
    end
end