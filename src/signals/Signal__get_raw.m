function Raw = Signal__get_raw(Signal)
%Returns the raw data of the signal
%
% Inputs:
%  Signal: the signal you want the raw data of
% Outputs:
%  Raw: the raw data of the signal
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

if(nargin ~= 1)
	error('Usage: Signal__get_raw(Signal)');
end

Signal__assert_mine(Signal);

Raw = Signal.raw;

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_raw(sig, [1 2 3 4]);
%! assert(Signal__get_raw(sig), [1 2 3 4]);
