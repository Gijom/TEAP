function samprate = Signal_get_samprate(Signal)
%Returns the sampling rate of a signal
% Inputs:
%  Signal: the signal you want to get the sampling rate
% Outputs:
%  samprate: the sampling rate of the signal, in hertz
%

if(nargin ~= 1)
	error('Usage: samprate = Signal_get_samprate(Signal)');
end

Signal_assert_mine(Signal);

samprate = Signal.samprate;

