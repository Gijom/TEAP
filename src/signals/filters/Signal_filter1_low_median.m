%> @file Signal_filter1_low_median.m
%> @brief Filters the signal with a low pass median filtering method
%> @param Signal: the signal to filter. Not a bulk signal !
%> @param windowSize: the window size (in samples)

%> @retval  Signal: the newly filtered signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal_filter1_low_median(Signal, windowSize)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_median(Signal, windowSize)');
end

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

filtered = smooth(raw, windowSize);

Signal = Signal__set_raw(Signal, filtered);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);

