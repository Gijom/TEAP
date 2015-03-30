function Signal = Signal_filter1_low_pass(Signal, cutOffFreq)
%A simple low-pass filter applyed to 1D signals (such as GSR, ECG, etc…).
% Inputs:
%  Signal: the signal to filter (will use the .raw component). Not a bulk sig. !
%  cutOffFreq: the cutOff frequency of the filter
% Outputs:
%  Signal: the low-passed-signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_pass(Signal, cutOffFreq)');
end

Signal__assert_mine(Signal);


%Take the sampling frequency of the signal
Fs = Signal__get_samprate(Signal);

%The normalized cutOff freq
Wn = (2/Fs)*cutOffFreq;

%Make the filter
b = fir1(20, Wn, 'low', kaiser(21, 3));

rawSignal = Signal__get_raw(Signal);

newRaw = filter(b, 1, rawSignal);

Signal = Signal__set_raw(Signal, newRaw);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);
