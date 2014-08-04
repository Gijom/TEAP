function HSTSignal = HST_filter_basic(HSTSignal)
%Cleans an HST signal using a low-pass mean filter. The window equals the sample
%rate, aka 1sec
% Inputs:
%  HSTSignal: the HST signal to filter
% Outputs:
%  HSTSignal: the HST signal filtered
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

HSTSignal = HST_assert_type(HSTSignal);

sampRate = Signal_get_samprate(HSTSignal);

HSTSignal = Signal_filter1_low_mean(HSTSignal, sampRate);

