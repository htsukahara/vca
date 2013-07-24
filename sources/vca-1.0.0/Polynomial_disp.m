function [varargout] = Polynomial_disp(varargin)
%Polynomial_disp Display the polynomial
%
% USAGE:
%   s = Polynomial_disp(poly);
%
% INPUTS:
%   poly - polynomial instance
%
% OUTPUTS:
%   s - string display of the polynomial

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

s = '';

if ~isempty(varargin)
    poly = varargin{1};

    [ind, K] = Index_comb(0, poly.degree, poly.nvars); 

    for k = 1 : K
        c = Polynomial_getCoeff(poly, ind(k, :));
        if c ~= 0
            if length(s) > 0
                s = [s ' + '];
            end
            m = Monomial_disp(ind(k,:));
            if length(m) > 0
                s = [s num2str(c) '*' m];
            else
                s = [s num2str(c)];
            end
        end
    end
end

varargout{1} = s;

end