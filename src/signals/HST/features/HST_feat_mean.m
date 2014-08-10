function [meanTemp] = HST_feat_mean(HSTsignal)
%Computes the mean of the HST signal (aka the mean temperature)
% Inputs:
%  HSTsignal: the HST signal.
% Outputs:
%  meanTemp: the mean temperature, in °C
%
% WARNING: this function will give 'strange' results when applied on a relative
%          signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have a HST signal
HSTsignal = HST_assert_type(HSTsignal);


if(~Signal_has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a mean filter']);
end

if(Signal_get_absolute(HSTsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end

raw = Signal_get_raw(HSTsignal);

meanTemp = mean(raw);


