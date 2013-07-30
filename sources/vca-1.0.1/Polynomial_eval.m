function [varargout] = Polynomial_eval(varargin)
%Polynomial_eval Evaluate a polynomial
%
% USAGE:
%   v = Polynomial_eval(poly, x);
%
% INPUTS:
%   poly - polynomial instance
%   x : array - values of variables
%
% OUTPUTS:
%   v - value of the polynomial for a given value x

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

v = 0;

if length(varargin) > 1
    poly = varargin{1};
    x = varargin{2};

    [ind, K] = Index_comb(0, poly.degree, poly.nvars); 

    n = size(x, 1);
    v = zeros(n, 1);
        
    for k = 1 : K
        c = Polynomial_getCoeff(poly, ind(k, :));  
        for l = 1 : n
            v(l) = v(l) + c * prod(x(l, :) .^ ind(k, :));
        end
    end
end

varargout{1} = v;

end
