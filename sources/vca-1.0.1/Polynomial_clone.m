function [varargout] = Polynomial_clone(varargin)
%Polynomial_clone Clone a polynomial
%
% USAGE:
%   poly2 = Polynomial_clone(poly1);
%
% INPUTS:
%   poly1 - polynomial instances
%
% OUTPUTS:
%   poly2 - clone of poly1

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly1 = varargin{1};

poly2 = Polynomial(poly1.nvars, poly1.degree); 

s = ['poly2.coeffs(1:' num2str(poly1.degree) + 1];
for k = 2 : poly2.nvars
    s = [s ', 1:' num2str(poly1.degree) + 1];
end
s = [s ')'];
eval([s ' = poly1.coeffs;']);

varargout{1} = poly2;

end
