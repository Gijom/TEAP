function [energy] = RES_feat_energy(RESsignal)
%Computes the energy of a respiration signal.
% Inputs:
%  RESsignal: the RES signal.
%
%Outputs:
%  energy: the energy of the signal
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);

%Compute the features
if(~Signal__has_preproc_lowpass(RESsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a median filter']);
end

raw = Signal__get_raw(RESsignal);

energy = var(raw); 

