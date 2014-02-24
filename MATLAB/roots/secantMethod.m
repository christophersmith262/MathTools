%
% secantMethod(f, var, x0, x1, acc=0.001, max=100, debug=false)
%
% By: Christopher Smith
%
% Usage: syms x; secantMethod(x-3, x -3, 3)
%
% Description:
%
%    Applies x_n+1 = x_n-1 - (x_n - x_n-1)/(f(x_n) - f(x_n-1))
%    to a function f to attempt to find its root near x0.
%
% Arguments:
%
%    f:     the function to be evaluated
%    var:   the independent variable
%    x0:    The first initial guess
%    x1:    The second initial guess
%    acc:   the desired accuracy of the result
%    max:   the maximum number of iterations to try
%    debug: if set to true debug info will be printed and
%           'max' iterations are garenteed to be run
%
% Returns:
%
%    r:   the root (or NaN if an error occurred)
%    j:   the number of iterations used
%    err: an error code (see below)
%
%
% Error Codes:
%
%    0: No error occurred, result is in 'r'
%   -1: Not within desired accuracy after max iterations
%   -2: Division by zero, f(x1)-f(x0) was 0
%
function [ r, j, err ] = secantMethod(f, var, x0, x1, acc, max, debug)
    syms x;
    f = matlabFunction(f, 'vars', sym(var));
    err = -1;
    
    if nargin < 7,
        debug = false;
    end
    
    if nargin < 6,
        max = 100;
    end
    
    if nargin < 5,
        acc = 0.001;
    end
    
    if debug,
        fprintf('\tDEBUG: secantMethod(%s, %f, %f, %f, %d, %d): \n', func2str(f), x0, x1, acc, max, debug);
        fprintf('\tDEBUG:   n      x_n        f(x_n)       x_n+1    f(x_n+1)      x_n+2\n');
    end

    for j=1:max,
        
        % Get the denominator of the adjustment
        % and ensure we will not have a division
        % by 0 case.
        denom = f(x1) - f(x0);
        if denom == 0,
            err = -2;
            break;
        end

        % Apply the next iteration of the Secant Method
        x2 = x1 - ((x1 - x0)/denom)*f(x1);
        
        if debug,
            fprintf('\tDEBUG:   %d      %3.3f      %3.3f      %3.3f      %3.3f      %3.3f\n', j-1, x0, f(x0), x1, f(x1), x2);
        end
        
        % Check if we have arrived at a root
        if abs(f(x2)) <= acc && ~debug,
            err = 0;
            break;
        end
        
        x0 = x1;
        x1 = x2;
    end
    
    if err ~= 0 && ~debug,
        r = NaN;
    else
        r = x2;
    end
end