function [varargout] = Test_generateParabolicCurveData(varargin)
%Test_generateParabolicCurveData Generates a data set of parabolic curve components
%   
%   Generates a set of points distibuted over several parabolic curve components.   
% 
% USAGE:
%   Sm = Test_generateParabolicCurveData(N, K, d, r, p)
%
% INPUTS:
%   N - number of data
%   K - number of lines
%   d - dimension of data
%   r - noise rate
%
% OUTPUTS:
%   Sm - test data

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/29, Hiroshi Tsukahara, Created.

% default settings
N = 100;
K = 1;
d = 2;
r = 0.0;

% replace with specified settings if they are ginven
if nargin > 0
    N = varargin{1};
end

if nargin > 1
    K = varargin{2};
end

a = randn(K * d, d);
b = randn(K, 1);
p = 10 * randn(K, 1);

if nargin > 2
    d = varargin{3};
end

if nargin > 3
    r = varargin{4};
end

if nargin > 4
    p = varargin{5};
end

Sm = zeros(N * K, d);
for k = 1 : K
    t = 0.01 * [-N/2+1:N/2]';
    Sm(N * (k - 1) + 1 : N * k, 1) = 2 * p(k) * t;
    Sm(N * (k - 1) + 1 : N * k, 2) = p(k) * (t .* t);
%     Sm(N * (k - 1) + 1 : N * k, :) = Sm(N * (k - 1) + 1: N * k, :) * a(d * (k - 1) + 1: d * k, :);
%     Sm(N * (k - 1) + 1 : N * k, :) = Sm(N * (k - 1) + 1: N * k, :) + b(k);
end

filename = ['ParabolicCurveData.N-' num2str(N) '_K-' num2str(K) '_d-' num2str(d) '_r-' num2str(r) '.mat'];
save(filename, 'Sm', 'N', 'd', 'r', 'a', 'b', 'p');

varargout{1} = Sm;

end

