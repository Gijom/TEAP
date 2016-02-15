%> @file Signal__set_offset.m
%> @brief Sets the offset of the specified signal
%> @param  Signal: the signal
%> @param  offset: the offset of the signal, in frames/samples
%> @retval Signal: the modified signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__set_offset(Signal, offset)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal__set_offset(Signal, offset)');
end

Signal__assert_mine(Signal);

Signal.relatime = offset;


