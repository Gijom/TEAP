function Signal = Signal_filter1_low_median(Signal, windowSize)
%Filters the signal with a low pass median filtering method
% Inputs:
%  Signal: the signal to filter. Not a bulk signal !
%  windowSize: the window size (in samples)
% Outputs:
%  Signal: the newly filtered signal
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_median(Signal, windowSize)');
end

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

filtered = medfilt1(raw, windowSize);

Signal = Signal__set_raw(Signal, filtered);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);

