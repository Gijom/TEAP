function [minmax] = RES_feat_minmax(RESsignal)
%Computes the peak-to-peak value of a respiration signal (aka greatest breath).
% Inputs:
%  RESsignal: the RES signal.
%
%Outputs:
%  minmax: the greatest breath of the patient.
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

%%FIXME: this may be not always true ! Must find on single wave
minmax = max(raw) - min(raw);

