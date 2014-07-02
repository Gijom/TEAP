function [minmax RESsignal] = RES_feat_minmax(RESsignal)
%Computes the peak-to-peak value of a respiration signal (aka greatest breath).
% Inputs:
%  RESsignal: the RES signal.
%
%Outputs:
%  minmax: the greatest breath of the patient.
%  RESSignal: the RES signal with the values computed inside: will be faster if
%          you run-it a second time: if the feature was already computed for
%          this signal, only fetches the results.
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

%Make sure we have a RES signal
RES_assert_type(RESsignal)

%If the features were already computed
if(Signal_has_feature(RESsignal, 'minmax'))
	sigFeatures = Signal_get_feature(RESsignal, 'minmax');
	energy = sigFeatures.value;
	return;
end

%Compute the features
if(~Signal_has_preproc_lowpass(RESsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a median filter']);
end

raw = Signal_get_raw(RESsignal);

%%FIXME: this may be not always true ! Must find on single wave
minmax = max(raw) - min(raw);

feature.value = minmax;
RESsignal = Signal_set_feature(RESsignal, 'minmax', feature);

