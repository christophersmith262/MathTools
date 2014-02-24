%
% newtonsMethod(f, var, x0, acc=0.001, max=100, debug=false)
%
% By: Christopher Smith
%
% Usage: syms x; newtonsMethod(x-3, x, 2)
%
% Description:
%
%    Applies x_n+1 = x_n - f(x_n)/f'(x_n) to a function f
%    to attempt to find its root near x0.
%
% Arguments:
%
%    f:     the function to be evaluated
%    var:   the independent variable
%    x0:    the initial guess
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
%   -2: Division by zero, newtons method failed because f'(r) was 0
%   -3: The sequence began to diverge
%
function [ r, j, err ] = newtonsMethod(f, var, x0, acc, max, debug)
    df1 = matlabFunction(diff(f), 'vars', sym(var));
    f = matlabFunction(f, 'vars', sym(var));
    err = -1;
    
    r0 = x0;
    r  = x0;
    
    if nargin < 6,
        debug = false;
    end
    
    if nargin < 5,
        max = 100;
    end
    
    if nargin < 4,
        acc = 0.001;
    end
    
    if debug,
        fprintf('\tDEBUG: newtonsMethod(%s, %f, %f, %d, %d): \n', func2str(f), x0, acc, max, debug);
        fprintf('\tDEBUG:   n      x_n        f(x)       f''(x)      x_n+1\n');
    end

    for j=1:max,
        
        % Get the denominator of the adjustment
        % and ensure we will not have a division
        % by 0 case.
        denom = df1(r0);
        if denom == 0,
            err = -2;
            break;
        end

        % Apply the next iteration of Newtons Method
        r = r0 - f(r0)/denom;
        
        if debug,
            fprintf('\tDEBUG:   %d      %3.3f      %3.3f      %3.3f      %3.3f\n', j-1, r0, f(r0), df1(r0), r);
        end
        
        % Check if we have arrived at a root
        if abs(f(r)) <= acc && ~debug,
            err = 0;
            break;
        end
        
        % Check if the sequence is diverging
        if (abs(f(r)) > abs(f(r0)) || f(r) == f(r0)) && ~debug,
            err = -3;
            break;
        end

        r0 = r;
    end
    
    if err ~= 0 && ~debug,
        r = NaN;
    end
end