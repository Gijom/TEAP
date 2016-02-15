%> @brief Returns the raw data of the signal
%> @param  Signal: the signal you want the raw data of
%> @retval  Raw: the raw data of the signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Raw = Signal__get_raw(Signal)

if(nargin ~= 1)
	error('Usage: Signal__get_raw(Signal)');
end

Signal__assert_mine(Signal);

Raw = Signal.raw;

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_raw(sig, [1 2 3 4]);
%! assert(Signal__get_raw(sig), [1 2 3 4]);
