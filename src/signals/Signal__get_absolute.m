function [isAbsolute] = Signal__get_absolute(Signal)
%Is the signal data absolute or relative ?
% Inputs:
%  Signal
% Outputs:
%  isAbsolute: true/false depending on if it is absolute (true) or relative
%              (false) data.
%
%SEE ALSO:
% Signal__set_absolute
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 1)
	error('Usage: isAbsolute = Signal__get_absolute(Signal)');
end

isAbsolute = Signal.isAbsolute;


