function [energy RESsignal] = RES_feat_energy(RESsignal)
%Computes the energy of a respiration signal.
% Inputs:
%  RESsignal: the RES signal.
%
%Outputs:
%  energy: the energy of the signal
%  RESSignal: the RES signal with the values computed inside: will be faster if
%          you run-it a second time: if the feature was already computed for
%          this signal, only fetches the results.
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

%Make sure we have a RES signal
RES_assert_type(RESsignal)

%If the features were already computed
if(Signal_has_feature(RESsignal, 'energy'))
	sigFeatures = Signal_get_feature(RESsignal, 'energy');
	energy = sigFeatures.value;
	return;
end

%Compute the features
if(~Signal_has_preproc_lowpass(RESsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a median filter']);
end

raw = Signal_get_raw(RESsignal);

energy = std(raw); %%FIXME: mail Guillaume. sum(raw.^2) ?

feature.value = energy;
RESsignal = Signal_set_feature(RESsignal, 'energy', feature);

