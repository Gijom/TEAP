function [meanTemp HSTsignal] = HST_feat_mean(HSTsignal)
%Computes the mean of the HST signal (aka the mean temperature)
% Inputs:
%  HSTsignal: the HST signal.
%
% Outputs:
%  meanTemp: the mean temperature, in °C
%  Signal: the HST signal with the values computed inside: will be faster if
%          you run-it a second time: if the feature was already comptued for
%          this signal, only fetches the results.
% WARNING: this function will give 'strange' results when applied on a relative
%          signal
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have a HST signal
HST_assert_type(HSTsignal)

%If the features were already computed
if(Signal_has_feature(HSTsignal, 'mean'))
	sigFeatures = Signal_get_feature(HSTsignal, 'mean');
	meanTemp = sigFeatures.value;
	return;
end


if(~Signal_has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a mean filter']);
end

if(Signal_get_absolute(HSTsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end

raw = Signal_get_raw(HSTsignal);

calcFeatures.value = mean(raw);
meanTemp = calcFeatures.value;

HSTsignal = Signal_set_feature(HSTsignal, 'mean', calcFeatures);

