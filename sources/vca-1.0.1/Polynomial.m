function [varargout] = Polynomial(varargin)
%Polynomial Constructor
%
% USAGE:
%   [p] = Polynomial(n, d);
%
% INPUTS:
%   n : Z>0 - number of variables
%   d : Z>0 - degree of a polynomial
%   f0 : R - constant term
%   f1 : Z>0(n) -> R - coeeficients of a polynomial
%
% OUTPUTS:
%   p - polynomial instance

% Copyright 2013 Denso IT Laboratory, Inc.

% CHANGE LOG:
% [001] 2013/07/24, Hiroshi Tsukahara, Created.

n = varargin{1};
d = varargin{2};


poly.nvars = n;
poly.degree = d;
poly.coeffs = initializeCoefficients(n, d);

% if length(varargin) > 2
%     poly.const = varargin{3};
% end
% 
% if length(varargin) > 3
%     poly.coeffs = varargin{4};
% end

varargout{1} = poly;

end

function [f1] = initializeCoefficients(n, d)
   s = ['zeros(' num2str(d + 1)];
   for k = 2 : n
      s = [s ', ' num2str(d + 1)]; 
   end
   s = [s ');'];
   f1 = eval(s);
end
