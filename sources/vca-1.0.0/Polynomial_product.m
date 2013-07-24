function [varargout] = Polynomial_product(varargin)
%Polynomial_product Product of two polynomials
%
% USAGE:
%   poly3 = Polynomial_product(poly1, poly2);
%
% INPUTS:
%   poly1, poly2 - polynomial instances
%
% OUTPUTS:
%   poly3 - product of poly1 and poly2

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly1 = varargin{1};
poly2 = varargin{2};

poly3 = Polynomial(max(poly1.nvars, poly2.nvars), poly1.degree * poly2.degree); 

ind1 = Index_comb(0, poly1.degree, poly1.nvars);
ind2 = Index_comb(0, poly2.degree, poly2.nvars);

K1 = size(ind1, 1);
K2 = size(ind2, 1);

for k1 = 1 : K1
    for k2 = 1 : K2
        ind = ind1(k1, :) + ind2(k2, :);
        a = Polynomial_getCoeff(poly1, ind1(k1, :));
        b = Polynomial_getCoeff(poly2, ind1(k1, :));
        c = Polynomial_getCoeff(poly3, ind);
        poly3 = Polynomial_setCoeff(poly3, c + a*b, ind);
    end
end

varargout{1} = poly3;

end
