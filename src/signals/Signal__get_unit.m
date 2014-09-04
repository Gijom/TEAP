function unit = Signal__get_unit(Signal)
%Gets the unit of a signal (ex: 'Ohm' for a GSR signal)
% Inputs:
%  Signal: the signal
% Outputs:
%  unit: a string naming the unit
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: unitName = Signal__get_unit(Signal)');
end

Signal__assert_mine(Signal);

unit = Signal.unit;

%!error(Signal__get_unit())
%!error(Signal__get_unit(42))

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_unit(sig, 'tu');
%! assert(Signal__get_unit(sig), 'tu');
