%> @brief Returns the sampling rate of a signal

%> @param  Signal: the signal you want to get the sampling rate

%> @retval  samprate: the sampling rate of the signal, in hertz
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function samprate = Signal__get_samprate(Signal)

if(nargin ~= 1)
	error('Usage: samprate = Signal__get_samprate(Signal)');
end

Signal__assert_mine(Signal);

samprate = Signal.samprate;

%!error(Signal__get_samprate());
%!error(Signal__get_samprate(42));

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_samprate(sig, 42);
%! assert(Signal__get_samprate(sig), 42);
