%
% bisectionMethod(f, var, a, b, acc=0.001, max=100, debug=false)
%
% By: Christopher Smith
%
% Usage: syms x; bisectionMethod(x-3, x, -5, 5)
%
% Description:
%
%    Applies the bisection algorithm to a function f
%    to attempt to find its root on the interval [a,b].
%
% Arguments:
%
%    f:     the function to be evaluated
%    var:   the independent variable
%    a:     the left end point of the interval to check
%    b:     the right end point of the interval to check
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
%   -2: The sequence began to diverge
%
function [ r, j, err ] = bisectionMethod(f, var, a, b, acc, max, debug)
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
        fprintf('\tDEBUG: bisectionMethod(%s, %f, %f, %f, %d, %d): \n', func2str(f), a, b, acc, max, debug);
        fprintf('\tDEBUG:   n      a         f(a)         b          f(b)       c         f(c)\n');
    end

    for j=1:max,
        c = (a + b) / 2;
        fa = f(a);
        fb = f(b);
        fc = f(c);
        
        if debug,
            fprintf('\tDEBUG:   %d      %3.3f      %3.3f      %3.3f      %3.3f      %3.3f      %3.3f\n', j-1, a, fa, b, fb, c, fc);
        end
    
        if sign(fa) == sign(fb),
            err = -2;
            break;
        end
    
        if abs(fc) <= acc && ~debug,
            r = c;
            err = 0;
            break;
        end
    
        if sign(fc) == sign(fa)
            a = c;
        else
            b = c;
        end
    end
    
    if err ~= 0 && ~debug,
        r = NaN;
    else
        r = c;
    end
end