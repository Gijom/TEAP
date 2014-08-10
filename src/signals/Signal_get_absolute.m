function [isAbsolute] = Signal_get_absolute(Signal)
%Is the signal data absolute or relative ?
% Inputs:
%  Signal
% Outputs:
%  isAbsolute: true/false depending on if it is absolute (true) or relative
%              (false) data.
%
%SEE ALSO:
% Signal_set_absolute
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: isAbsolute = Signal_get_absolute(Signal)');
end

isAbsolute = Signal.isAbsolute;


