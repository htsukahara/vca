function [K, n] = Index_comb( a, b, m )
%Index_comb Combination of monomial indices
%
% USAGE:
%   [K, n] = Index_comb( a, b, m );
%
% INPUTS:
%   a - minimum number of indices
%   b - maximum number of indices
%   m - number of tuples
%
% OUTPUTS:
%   K - matrix of index arrays
%   n - number of index arrays

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

if b < a
    tmp = a;
    a = b;
    b = tmp;
end

if m >= 2
    K1 = Index_comb(a, b, m-1);
    c = b - a + 1;
    K = zeros(c^m, m);
    l = 1;
    for k = a : b
        n = size(K1,1);
        K(l:l+n-1, :) = [K1, k * ones(n,1)];
        l = l + n;
    end
else
    K = (a:b)';
end
n = size(K, 1);
end

