function [varargout] = Monomial_disp(varargin)
%Monomial_disp Display a monomial
%
% USAGE:
%   v = Monomial_disp(ind);
%
% INPUTS:
%   ind - powers
%
% OUTPUTS:
%    v - string diplay of the polynomial

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

ind = varargin{1};

nvars = length(ind);

s = '';
for k = 1 : nvars
    if ind(k) > 0
        if length(s) > 0
            s = [s '*x' num2str(k) '^' num2str(ind(k))];
        else
            s = [s 'x' num2str(k) '^' num2str(ind(k))];
        end
    end
end

varargout{1} = s;

end
