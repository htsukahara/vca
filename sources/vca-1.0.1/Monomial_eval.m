function [varargout] = Monomial_eval(varargin)
%Monomial_eval Evaluate a polynomial
%
% USAGE:
%   v = Monomial_eval(x, ind);
%
% INPUTS:
%   x : array - values of variables
%   ind - powers
%
% OUTPUTS:
%    v - value of monomial

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

x = varargin{1};
ind = varargin{2};

n = size(x, 1);
v = zeros(n, 1);

for l = 1 : n
    v(l) = v(l) + prod(x(l, :) .^ ind(k, :));
end

varargout{1} = v;

end
