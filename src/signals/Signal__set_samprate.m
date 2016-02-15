%> @brief Sets the sampling rate of a signal
%> @param  Signal: the signal
%> @param  samprate: the sampling rate
%> @retval  Signal: the newly modified signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__set_samprate(Signal, samprate)

if(nargin ~= 2)
	error('Usage: Signal__set_samprate(Signal, samprate)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal__assert_mine(Signal);


Signal.samprate = samprate;

%!error(Signal__set_samprate())
%!error(Signal__set_samprate(42))
%!error(Signal__set_samprate(42, 43))
%!error(Signal__set_samprate(Signal__new_empty(), 42)) %result not retrieved
%!assert(Signal__get_samprate(Signal__set_samprate(Signal__new_empty(), 42)), 42)

