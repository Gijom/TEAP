function Signal = Signal_set_unit(Signal, unitStr)
%Sets the unit of a signal
%
% Inputs:
%  Signal: the signal you want to add the unit to
%  unitStr: the unit name (ex: 'Ohm');
% Outputs:
%  The newly modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: Signal = Signal_set_unit(Signal, unitStr)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal_assert_mine(Signal);

Signal.unit = unitStr;

%!error(Signal_set_unit())
%!error(Signal_set_unit(42))
%!error(Signal_set_unit(42, 43))
%!error(Signal_set_unit(Signal_new_empty(), 'ohm')) %result not retrieved
%!assert(Signal_get_unit(Signal_set_unit(Signal_new_empty(), 'ohm')), 'ohm')

