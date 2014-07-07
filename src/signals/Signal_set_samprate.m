function Signal = Signal_set_samprate(Signal, samprate)
%Sets the sampling rate of a signal
% Inputs:
%  Signal: the signal
%  samprate: the sampling rate
% Outputs:
%  Signal: the newly modified signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: Signal_set_samprate(Signal, samprate)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal_assert_mine(Signal);


Signal.samprate = samprate;

%!error(Signal_set_samprate())
%!error(Signal_set_samprate(42))
%!error(Signal_set_samprate(42, 43))
%!error(Signal_set_samprate(Signal_new_empty(), 42)) %result not retrieved
%!assert(Signal_get_samprate(Signal_set_samprate(Signal_new_empty(), 42)), 42)

