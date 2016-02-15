%> @brief Computes the energy of a respiration signal.

%> @param  RESsignal: the RES signal.

%> @retval  energy: the energy of the signal

%> @author Copyright Guillaume Chanel 2013
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [energy] = RES_feat_energy(RESsignal)

%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);

%Compute the features
if(~Signal__has_preproc_lowpass(RESsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a median filter']);
end

raw = Signal__get_raw(RESsignal);

energy = var(raw); 

