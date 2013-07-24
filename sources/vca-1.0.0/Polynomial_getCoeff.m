function [varargout] = Polynomial_getCoeff(varargin)
%Polynomial_getCoeff Gets coefficients of a polynomial
%
% USAGE:
%   c = Polynomial_getCoeff(poly, ind);
%
% INPUTS:
%   poly - polynomial instance
%
% OUTPUTS:
%   c - coefficient of the polynomial with the degree ind

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly = varargin{1};

if length(varargin) < 2
    c = poly.coeffs;
else
    ind = varargin{2};
    d = sum(ind);
    if d < 0 | d > poly.degree
        c = 0;
    else
        s = ['poly.coeffs(' num2str(ind(1) + 1)];
        for k = 2 : poly.nvars
            s = [s ', ' num2str(ind(k) + 1)];
        end
        s = [s ')'];
        c = eval(s);
    end
end

varargout{1} = c;

end
