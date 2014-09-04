function Signal = ECG_aqn_variable(ECG, ECG2, sampRate)
% ECG_aqn_variable gets an ECG signal from a variable
% Inputs:
%   ECG [1xN]:  the ECG signal
%   ECG2 [1xN]: the other pair ECG signal (optional if difference already calc.)
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: An ECG TEAPhysio signal
%
% USES:
% If you've got the signal from the 2 electrodes, you must call the function
% like that:
%  ECG_aqn_variable(electrode1, electrode2, sampRate);
% If, however, the difference was already calculated by your device, you can
% call the function that way:
%  ECG_aqn_variable(electrodesDiff, sampRate);
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal = ECG_new_empty();

if(nargin == 2) %second case
	sampRate = ECG2;
	raw = ECG;
else if(nargin == 3) %first case
	raw = ECG2 - ECG;
else
	error('Usage: ECG_aqn_variable(ECG [, ECG2], sampRate)');
end

Signal = Signal__set_samprate(Signal, sampRate);
Signal = Signal__set_raw(Signal, raw);

end

