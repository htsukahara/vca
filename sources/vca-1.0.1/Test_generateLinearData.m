function [varargout] = Test_generateLinearData(varargin)
%Test_generateLinearData Generates a linearly distributed test data
%   
%   Generates a set of points x satisfying Ax + b = 0.
% 
% USAGE:
%   Sm = Test_generateLinearData(N, K, d, r)
%
% INPUTS:
%   N - number of data
%   K - number of lines
%   d - dimension of data
%   r - noise rate
%   a - R(k, d) : normal direction of data points
%   b - R : constant
%
% OUTPUTS:
%   Sm - test data

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/28, Hiroshi Tsukahara, Created.

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

a = rand(K, d);
b = rand(K, 1);

if nargin > 2
    d = varargin{3};
end

if nargin > 3
    r = varargin{4};
end

if nargin > 4
    a = varargin{5};
end

if nargin > 5
    b = varargin{6};
end

Sm = rand(N * K, d);
for k = 1 : K
    t = [1:N]';
    Sm(N * (k - 1) + 1 : N * k, :) = Sm(N * (k - 1) + 1: N * k, :) - (Sm(N * (k -1) + 1: N * k, :) * a(k, :)') * a(k, :) / norm(a(k, :))^2;
    Sm(N * (k - 1) + 1 : N * k, :) = Sm(N * (k - 1) + 1: N * k, :) + b(k);
end

filename = ['LinearData.N-' num2str(N) '_K-' num2str(K) '_d-' num2str(d) '_r-' num2str(r) '.mat'];
save(filename, 'Sm', 'N', 'd', 'r', 'a', 'b');

varargout{1} = Sm;

end

