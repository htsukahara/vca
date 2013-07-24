function [varargout] = vca(varargin)
%VCA Vanishing Component Analysis
%
% USAGE:
%   [V, F] = vca(Sm, e);
%   
% INPUTS:
%   Sm : R(m, n) - m rows of n-dimensional vector data
%   e : R - torelance (positive value)
% 
% OUTPUTS:
%   V : cell array of polynomial instances - vanishing compoments
%   F : cell array of polynomial instances - non-vanishing compoments

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

Sm = varargin{1};
e = 1.0e-3;

if length(varargin) > 1
    e = varargin{2};
end

% m : number of data
% n : dimension of the data
[m, n] = size(Sm);

disp('Initialize Bases');

F{1} = Polynomial(n, 0);
F{1} = Polynomial_setCoeff(F{1}, 1 / sqrt(m), zeros(1, n));
V = {};
C1 = cell([n, 1]);
for k = 1 : n
   c = zeros(1, n);
   c(k) = 1;
   C1{k} = Polynomial(n, 1); 
   C1{k} = Polynomial_setCoeff(C1{k}, 1, c);
end

disp('First Iteration');
[F1, V1, S] = findRangeNull(F, C1, Sm, e);

disp(S);

F = {F{:}, F1{:}};
V = {V{:}, V1{:}};

Ft_1 = F1;

nIter = 1;
while 1
    Ct = generateBases(Ft_1, F1);
    
    if length(Ct) < 1
        break
    end
    
    nIter = nIter + 1;
    
    disp([num2str(nIter) ' Iteration']);
    
    [Ft, Vt, S] = findRangeNull(F, Ct, Sm, e);
    
    disp(S);

    F = {F{:}, Ft{:}};
    V = {V{:}, Vt{:}};
    
    Ft_1 = Ft;
end

varargout{1} = V;
varargout{2} = F;
end

function [Ct] = generateBases(Ft_1, F1)
K = length(Ft_1);
L = length(F1);
M = K * L;

Ct = cell([M, 1]);
m = 0;
for k = 1 : K
    for l = 1 : L
        m = m + 1;
        Ct{m} = Polynomial_product(Ft_1{k}, F1{l});
    end
end
end


function [Ft, Vt, S] = findRangeNull(F, Ct, Sm, e)
K = length(Ct);
L = length(F);
Dt = cell(K, 1);
A = zeros(size(Sm, 1), K);
for k = 1 : K
    for l = 1 : L
        fk = Polynomial_eval(Ct{k}, Sm);
        gl = Polynomial_eval(F{l}, Sm);
        d = sum(fk .* gl);
        Dt{k} = Polynomial_sum(Ct{k}, Polynomial_scalarMul(F{l}, -d));
        A(:, k) = Polynomial_eval(Dt{k}, Sm);
    end
end

[U,S,V] = svd(A);

Ft = {};
Vt = {};

for k1 = 1 : K
    def = Polynomial_getDef(Dt{1});
    g = Polynomial(def(1), def(2));
    for k2 = 1 : K
        g = Polynomial_sum(g, Polynomial_scalarMul(Dt{k2}, V(k2, k1)));
    end
    
    n = norm(Polynomial_eval(g, Sm));
    if n > 0
        g = Polynomial_scalarMul(g, 1/n);
    end
    
    if S(k1, k1) > e
%         n = norm(Polynomial_eval(g, Sm));
%         if n > 0
%             g = Polynomial_scalarMul(g, 1/n);
%         end
        Ft = {Ft{:}, g};
    else
        Vt = {Vt{:}, g};
    end
end

S = diag(S(1:K, 1:K));

end

