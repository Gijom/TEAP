%> @file HST_feat_meanderiv.m
%> @brief Computes the mean derivation of the HST signal.
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%> @param HSTsignal the HST signal.

%> @retval meanTemp the mean derivation of the temperature, in d°C/dt

function [meanTemp] = HST_feat_meanderiv(HSTsignal)

%Make sure we have a HST signal
HSTsignal = HST__assert_type(HSTsignal);

if(~Signal__has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a mean filter']);
end

raw = Signal__get_raw(HSTsignal);

meanTemp = mean(diff(raw));

