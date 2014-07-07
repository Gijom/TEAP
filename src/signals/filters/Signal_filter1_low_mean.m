function Signal = Signal_filter1_low_mean(Signal, windowSize)
%Filters the signal with a low pass mean filtering
% Inputs:
%  Signal: the signal to filter
%  windowSize: the window size (in samples)
% Outputs:
%  Signal: the newly filtered signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

raw = Signal_get_raw(Signal);


filtAvgEls = ones(1, windowSize)/windowSize;


raw = filtfilt(filtAvgEls, 1, [repmat(raw(1), windowSize, 1); raw']);

raw = raw';

%take out first second
raw = raw(windowSize+1:end);


Signal = Signal_set_raw(Signal, raw);

%Indicate that the signal has been filtered
Signal = Signal_set_preproc_lowpass(Signal);

