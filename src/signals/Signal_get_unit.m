function unit = Signal_get_unit(Signal)
%Gets the unit of a signal (ex: 'Ohm' for a GSR signal)
% Inputs:
%  Signal: the signal
% Outputs:
%  unit: a string naming the unit
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: unitName = Signal_get_unit(Signal)');
end

Signal_assert_mine(Signal);

unit = Signal.unit;

