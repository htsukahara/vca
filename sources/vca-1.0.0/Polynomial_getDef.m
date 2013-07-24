function [varargout] = Polynomial_getDef(varargin)
%Polynomial_getDef Gets definition of a polynomial
%
% USAGE:
%   [n, d] = Polynomial_getDef(poly);
%
% INPUTS:
%   poly - polynomial instance
%
% OUTPUTS:
%   n - number of variables
%   d - degree of the polynomial

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

poly = varargin{1};

def = [poly.nvars, poly.degree];

varargout{1} = def;

end
