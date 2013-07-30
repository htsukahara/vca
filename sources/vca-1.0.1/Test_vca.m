function [varargout] = Test_vca(varargin)
%Test_vca Tests VCA
%
% USAGE:
%   [V, F] = Test_vca(N, r, e, maxIter, [testName]);
%
% INPUTS:
%   Sm - R(N, d) matrix : input data
%   e - R : tolerance
%   maxIter : N - Maximum number of iterations
%   testName - string
%
% OUTPUTS:
%   V - vanishing components
%   F - non-vanishing components

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.
% [002] 2013/07/28, Hiroshi Tsukaahra, Modified so that the test data are given as an argument.
% [003] 2013/07/30, Hiroshi Tsukahara, Sets a limit for iterations.


Sm = varargin{1};
e = 0.1;
maxIter = Inf;
testName = 'Test_vca';

plotFlag = 0;

if nargin > 1
    e = varargin{2};
end

if length(varargin) > 2
    maxIter = varargin{3};
end

if nargin > 3
    testName = varargin{4};
end

d = size(Sm, 2);
Lm = zeros(d, 1);
for k = 1 : d
    Lm(k) = 1.5 * sqrt(max(Sm(:, k) .* Sm(:, k)));
end

[V, F] = vca(Sm, e, maxIter);

disp('Vanishing Compoments');
for k = 1 : length(V)
    s = ['V[' num2str(k) ']: ' Polynomial_disp(V{k})];
    disp(s);
end

N = size(Sm, 1);
filename = [testName '.N-' num2str(N) '_e-' num2str(e) '.mat'];
save(filename, 'V', 'F', 'Sm', 'e');

varargout{1} = V;
varargout{2} = F;

o = '[';
s = 'ndgrid(';
for k = 1 : d
   if k > 1
       o = [o ', '];
       s = [s ', '];
   end
   o = [o 'g' num2str(k)];
   s = [s '-' num2str(Lm(k)) ':' num2str(Lm(k)) '/50:' num2str(Lm(k))];
end
o = [o ']'];
s = [s ');'];

eval([o '=' s]);

plotData(Sm);
for k = 1 : length(V)
    figure;
    switch d
        case 2
            plotVca(g1, g2, Sm, V, e, k, plotFlag);
        case 3
            plotVca3(g1, g2, g3, Sm, V, e, k);
    end
end
end

function plotData(Sm)
    figure;
    plot(Sm(:, 1), Sm(:, 2), 'o');
    legend('data');
end

function plotVca(gx, gy, Sm, V, e, K, plotFlag)
cmap = lines;
plot(Sm(:, 1), Sm(:, 2), 'o', 'Color', cmap(1, :));
hold on;

plotName = cell(K + 1, 1);
plotName{1} = 'data';
for k = 1 : K
   plotContour(gx, gy, V{k}, e, cmap, k, plotFlag); 
   if plotFlag
       plotName{2 * k} = ['V{' num2str(k) '}.bound'];
       plotName{2 * k + 1} = ['V{' num2str(k) '}.center'];
   else
       plotName{k + 1} = ['V{' num2str(k) '}'];
   end
end
legend(plotName{:});
hold off;
end

function plotContour(gx, gy, poly, e, cmap, m, plotFlag)
    z = zeros(size(gx));
    for k = 1 : size(gx, 2)
       z(:,k) = Polynomial_eval(poly, [gx(:, k), gy(:, k)]); 
    end
    if plotFlag
        contour(gx, gy, z, [-e, e], 'Color', cmap(m + 1,:), 'LineWidth', 1.5);
        contour(gx, gy, z, [0, 0], 'Color', cmap(m + 1,:), 'LineWidth', 1, 'LineStyle', '-.');
    else
        contour(gx, gy, z, [-e, e], 'Color', cmap(m + 1,:), 'LineWidth', 1.5);
    end
end

function plot3Vca(gx, gy, gz, Sm, V, e, K)
cmap = lines;
plot3(Sm(:, 1), Sm(:, 2), Sm(:, 3), 'o', 'Color', cmap(1, :));
hold on;

plotName = cell(K + 1, 1);
plotName{1} = 'data';
for k = 1 : K
   plotContour3(gx, gy, gz, V{k}, e, cmap, k); 
   plotName{k + 1} = ['V{' num2str(k) '}'];
end
legend(plotName{:});
hold off;
end

function plotContour3(gx, gy, gz, poly, e, cmap, m)
    v = zeros(size(gx));
    for k = 1 : size(gx, 2)
       v(:,k) = Polynomial_eval(poly, [gx(:, k), gy(:, k), gz(:,k)]); 
    end
    hpatch = patch(isosurface(gx, gy, gz, v, 0));
    set(hpatch, 'FaceColor', cmap(m + 1,:), 'EdgeColor', 'none')
    daspect([1,4,4])
    view([-65,20])
    axis tight
    camlight left; 
    set(gcf,'Renderer','zbuffer'); lighting phong
end

 