function Raw = Signal_get_raw(Signal)
%Returns the raw data of the signal
%
% Inputs:
%  Signal: the signal you want the raw data of
% Outputs:
%  Raw: the raw data of the signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: Signal_get_raw(Signal)');
end

Signal_assert_mine(Signal);

Raw = Signal.raw;

%!test
%! sig = Signal_new_empty();
%! sig = Signal_set_raw(sig, [1 2 3 4]);
%! assert(Signal_get_raw(sig), [1 2 3 4]);
