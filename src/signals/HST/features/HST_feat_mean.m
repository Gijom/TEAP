%> @file HST_feat_mean.m
%> @brief Computes the mean of the HST signal (aka the mean temperature)
%> @b WARNING: this function will give 'strange' results when applied on a relative
%> signal
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%> @param HSTsignal the HST signal.

%> @retval meanTemp the mean temperature, in °C

function [meanTemp] = HST_feat_mean(HSTsignal)

%Make sure we have a HST signal
HSTsignal = HST__assert_type(HSTsignal);


if(~Signal__has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a mean filter']);
end

if(Signal__get_absolute(HSTsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end

raw = Signal__get_raw(HSTsignal);

meanTemp = mean(raw);


