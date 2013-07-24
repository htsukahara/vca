function [varargout] = Polynomial_copy(varargin)
%Polynomial_copy Copy of coefficients of a polynomial
%
% USAGE:
%   poly1 = Polynomial_copy(poly1, poly2);
%
% INPUTS:
%   poly1 - polynomial instances
%   poly2 - polynomial instances
%
% OUTPUTS:
%   poly1 - copy of poly2

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly1 = varargin{1};
poly2 = varargin{2};

if poly1.nvars < poly2.nvars | poly1.degree < poly2.degree
    poly1 = Polynomial(max(poly1.nvars, poly2.nvars), max(poly1.degree, poly2.degree));
end 

s = ['poly1.coeffs(1:' num2str(poly2.degree) + 1];
for k = 2 : poly2.nvars
    s = [s ', 1:' num2str(poly2.degree) + 1];
end
s = [s ')'];
eval([s ' = poly2.coeffs;']);

varargout{1} = poly1;

end
