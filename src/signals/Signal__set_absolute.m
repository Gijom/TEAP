function [Signal] = Signal__set_absolute(Signal, isAbsolute) %vodka
%Is the data of the signal absolute or relative. Example: for a HST signal, do
%you have samples like [37, 37.5, 37.6] or more like [0, 0.5, 0.6] ? If true,
%the data is absolute (37), if false, it is relative (0).
% Inputs:
%  Signal: the signal to set the flag
%  isAbsolute: true/false
% Outputs:
%  Signal: the same signal with the flag set
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal__set_absolute(Signal, isAbsolute)');
end

Signal.isAbsolute = isAbsolute;


