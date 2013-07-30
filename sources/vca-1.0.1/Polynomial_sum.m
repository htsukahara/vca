function [varargout] = Polynomial_sum(varargin)
%Polynomial_sum Sum of two polynomials
%
% USAGE:
%   poly3 = Polynomial_sum(poly1, poly2);
%
% INPUTS:
%   poly1, poly2 - polynomial instances
%
% OUTPUTS:
%   poly3 - sum of poly1 and poly2

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly1 = varargin{1};
poly2 = varargin{2};

poly3 = Polynomial(max(poly1.nvars, poly2.nvars), max(poly1.degree, poly2.degree)); 

s = ['poly3.coeffs(1:' num2str(poly1.degree + 1)];
for k = 2 : poly3.nvars
    s = [s ', 1:' num2str(poly1.degree + 1)];
end
s = [s ')'];
eval([s ' = poly1.coeffs;']);


s = ['poly3.coeffs(1:' num2str(poly2.degree + 1)];
for k = 2 : poly3.nvars
    s = [s ', 1:' num2str(poly2.degree + 1)];
end
s = [s ')'];
eval([s ' = ' s ' + poly2.coeffs;']);

varargout{1} = poly3;

end
