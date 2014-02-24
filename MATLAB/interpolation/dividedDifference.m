%
% dividedDifference(points)
%
% By: Christopher Smith
%
% Usage: A = dividedDifference([0, 1; 2,3; 4,5])
%
% Description:
%
%    Generates a matrix in which column vector 'i'
%    contains the divided differences of order 'i'
%    of the points matrix.
%
%    The diagonals of this matrix contain entries
%    [y1], [y1,y2], [y1,y2,y3], ...
%
% Arguments:
%
%    points: A n x 2 matrix of x,y pairs (x in the first
%            column, y in the second column where n is the
%            number of points in question.
%
% Returns:
%
%    DD: An n x n matrix containing the computed divided
%        differences (see description).
%
function [ DD ] = dividedDifference( points )
    n = length(points);
    DD = zeros(n,n);
    for i=1:n,
        for j=i:n,
            if i == 1,
                DD(j, i) = points(j, 2);
            else
                DD(j, i) = (DD(j,i-1) - DD(j-1,i-1)) / (points(j, 1) - points(j-i+1, 1));
            end
        end
    end
end

