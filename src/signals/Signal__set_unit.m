%> @file Signal__set_unit.m
%> @brief Sets the unit of a signal

%> @param Signal the signal you want to add the unit to
%> @param unitStr the unit name (ex: 'Ohm');

%> @retval Signal the newly modified signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__set_unit(Signal, unitStr)

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_unit(Signal, unitStr)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal__assert_mine(Signal);

Signal.unit = unitStr;

%!error(Signal__set_unit())
%!error(Signal__set_unit(42))
%!error(Signal__set_unit(42, 43))
%!error(Signal__set_unit(Signal__new_empty(), 'ohm')) %result not retrieved
%!assert(Signal__get_unit(Signal__set_unit(Signal__new_empty(), 'ohm')), 'ohm')

