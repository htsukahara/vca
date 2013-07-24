function [varargout] = Test_vca(varargin)
%Test_vca Tests VCA
%
% USAGE:
%   [V, F] = Test_vca(N, r, e, Lx, Ly);
%
% INPUTS:
%   N - number of data
%   r - noise rate
%   e - tolerance
%   Lx - size of x dimension
%   Ly - size of y dimension
%
% OUTPUTS:
%   V - vanishing components
%   F - non-vanishing components

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

N  = 100;
e = 0.1;
r = 0.1;
Lx = 2;
Ly = 2;

if nargin > 0
    N = varargin{1};
end

if nargin > 1
    e = varargin{2};
end

if nargin > 2
    r = varargin{3};
end

if nargin > 3
    Lx = varargin{4};
end

if nargin > 4
    Ly = varargin{5};
end

%------------- Customize begin ------------
% data with small noizes
t = [1:N]';
X = cos(t) + 0.1 * (rand(size(t)) - 0.5);
Y = sin(t) + 0.1 * (rand(size(t)) - 0.5);

% outliers
t = unique(randi(N, [round(N * r), 1]));
X(t) = X(t) + 10 * (rand(size(t)) - 0.5);
Y(t) = Y(t) + 10 * (rand(size(t)) - 0.5);
%------------- Customize end --------------

Lxm = 1.5 * sqrt(max(X.*X));
Lym = 1.5 * sqrt(max(Y.*Y));

if Lx > 2 * Lxm
    Lx = 2 * Lxm;
end

if Ly > 2 * Lym
    Ly = 2 * Lym;
end

Sm = [X, Y];


[V, F] = vca(Sm, e);

disp('Vanishing Compoments');
for k = 1 : length(V)
    s = ['V[' num2str(k) ']: ' Polynomial_disp(V{k})];
    disp(s);
end

filename = ['Test_vca.N-' num2str(N) '_e-' num2str(e) '_r-' num2str(r) '.mat'];
save(filename, 'V', 'F', 'Sm');

varargout{1} = V;
varargout{2} = F;

[gx, gy] = ndgrid(-Lx:Lx/50:Lx, -Ly:Ly/50:Ly);
for k = 1 : length(V)
    plotVca(gx, gy, Sm, V, e, k);
end
end

function plotVca(gx, gy, Sm, V, e, K)
cmap = lines;
plot(Sm(:, 1), Sm(:, 2), '.', 'Color', cmap(1, :));
hold on;

plotName = cell(K + 1, 1);
plotName{1} = 'data';
for k = 1 : K
   plotContour(gx, gy, V{k}, e, cmap, k); 
   plotName{k + 1} = ['V{' num2str(k) '}'];
end
legend(plotName{:});
hold off;
figure;
end

function plotContour(gx, gy, poly, e, cmap, m)
    z = zeros(size(gx));
    for k = 1 : size(gx, 2)
       z(:,k) = Polynomial_eval(poly, [gx(:, k), gy(:, k)]); 
    end
    contour(gx, gy, z, [-e, e], 'Color', cmap(m,:), 'LineWidth', 1.5);
end

 