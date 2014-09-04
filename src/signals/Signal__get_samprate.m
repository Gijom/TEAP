function samprate = Signal__get_samprate(Signal)
%Returns the sampling rate of a signal
% Inputs:
%  Signal: the signal you want to get the sampling rate
% Outputs:
%  samprate: the sampling rate of the signal, in hertz
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

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
