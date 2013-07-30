function [varargout] = Polynomial_setCoeff(varargin)
%Polynomial_setCoeff Sets coefficients of a polynomial
%
% USAGE:
%   poly = Polynomial_setCoeff(poly, c, ind);
%
% INPUTS:
%   poly - polynomial instance
%   c - coefficient
%   ind - index of the monomial
%
% OUTPUTS:
%   poly - polynomial instance 

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly = varargin{1};
c = varargin{2};
ind = varargin{3};

if length(varargin) < 3
    poly.coeffs = c;
else
    d = max(ind);
    if d >= 0 & d <= poly.degree
        s = ['poly.coeffs(' num2str(ind(1) + 1)];
        for k = 2 : poly.nvars
            s = [s ', ' num2str(ind(k) + 1)];
        end
        s = [s ') = ' num2str(c) ';'];
        eval(s);
    else
        % extend the coefficient matrix and copy data
        d0 = poly.degree;
        c0 = poly.coeffs;
        poly = Polynomial(poly.nvars, d);
        s = ['poly.coeffs(1:' num2str(d0 + 1)];
        for k = 2 : poly.nvars
            s = [s ', 1:' num2str(d0 + 1)];
        end
        s = [s ') = c0;'];
        eval(s);
        
        % sets the specified value
        s = ['poly.coeffs(' num2str(ind(1) + 1)];
        for k = 2 : poly.nvars
            s = [s ', ' num2str(ind(k) + 1)];
        end
        s = [s ') = ' num2str(c) ';'];
        eval(s);
    end
end

varargout{1} = poly;

end
