function [varargout] = Polynomial_scalarMul(varargin)
%Polynomial_scalarMul Scalar multiplication of a polynomial
%
% USAGE:
%   poly = Polynomial_scalarMul(poly, c);
%
% INPUTS:
%   poly - polynomial instances
%   c - scalar
%
% OUTPUTS:
%   poly - new polynomial = c * ploy

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly = varargin{1};

if nargin > 1
    c = varargin{2};
else
    c = 1;
end

poly.coeffs = c * poly.coeffs;

varargout{1} = poly;

end
