%> @brief Cleans an HST signal using a low-pass mean filter. The window equals the sample
%> rate, aka 1sec
%> Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%> @param  HSTSignal the HST signal to filter

%> @retval HSTSignal the HST signal filtered
function HSTSignal = HST_filter_basic(HSTSignal)

HSTSignal = HST__assert_type(HSTSignal);

sampRate = Signal__get_samprate(HSTSignal);

HSTSignal = Signal_filter1_low_mean(HSTSignal, sampRate);

