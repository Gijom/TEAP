%> @file Signal__get_unit.m
%> @brief Gets the unit of a signal (ex: 'Ohm' for a GSR signal)
%> @param  Signal: the signal
%> @retval  unit: a string naming the unit
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function unit = Signal__get_unit(Signal)

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
