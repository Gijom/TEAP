function [meanTemp] = HST_feat_meanderiv(HSTsignal)
%Computes the mean derivation of the HST signal.
% Inputs:
%  HSTsignal: the HST signal.
%
% Outputs:
%  meanTemp: the mean derivation of the temperature, in d°C/dt
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have a HST signal
HST_assert_type(HSTsignal)

if(~Signal_has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a mean filter']);
end

raw = Signal_get_raw(HSTsignal);

meanTemp = mean(diff(raw));

