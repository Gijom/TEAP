function Signal = EMG_aqn_variable(EMG, EMG2, sampRate)
% EMG_aqn_variable gets an EMG signal from a variable
% Inputs:
%   EMG [1xN]:  the EMG signal
%   EMG2 [1xN]: the other pair EMG signal (optional if difference already calc.)
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: An EMG TEAPhysio signal
%
% USES:
% If you've got the signal from the 2 electrodes, you must call the function
% like that:
%  EMG_aqn_variable(electrode1, electrode2, sampRate);
% If, however, the difference was already calculated by your device, you can
% call the function that way:
%  EMG_aqn_variable(electrodesDiff, sampRate);
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Signal = EMG__new_empty();

if(nargin == 2) %second case
	sampRate = EMG2;
	raw = EMG;
elseif(nargin == 3) %first case
	raw = EMG2 - EMG;
else
	error('Usage: EMG_aqn_variable(EMG [, EMG2], sampRate)');
end

Signal = Signal__set_samprate(Signal, sampRate);
Signal = Signal__set_raw(Signal, raw);

end

