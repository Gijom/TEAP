function HSTSignal = HST_filter_basic(HSTSignal)
%Cleans an HST signal using a low-pass mean filter. The window equals the sample
%rate, aka 1sec
% Inputs:
%  HSTSignal: the HST signal to filter
% Outputs:
%  HSTSignal: the HST signal filtered
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

HSTSignal = HST__assert_type(HSTSignal);

sampRate = Signal__get_samprate(HSTSignal);

HSTSignal = Signal_filter1_low_mean(HSTSignal, sampRate);

