function [Signal] = Signal_filter1_low_median(Signal, windowSize)
%Filters the signal with a low pass media filtering method
% Inputs:
%  Signal: the signal to filter
%  windowSize: the window size (in samples)
% Outputs:
%  Signal: the newly filtered signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

raw = Signal_get_raw(Signal);

filtered = medfilt1(raw, windowSize);

Signal = Signal_set_raw(filtered);

