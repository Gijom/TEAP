function Signal = EEG_aqn_variable(eegChannels, eegData, sampRate)
% EEG_aqn_variable gets an EEG signal from a variable.
% Inputs:
%   eegChannels [Cxstrings]: a vector specifying the C EEG channels given
%   eegData [CxN]: a matrix containing the EEG data
%   sampRate [1x1]: the sampling rate, in Hz
% Outputs:
%   Signal: An EEG TEAPhysio signal

if(nargin ~= 3)
	error('Usage: Signal = EEG_aqn_variable(eegChannels, eegData, sampRate');
end


Signal = EEG__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

[nChannels, ~] = size(eegChannels);
[nChannelsGiven, ~] = size(eegData);

if(nChannelsGiven ~= nChannels)
	error(['Hey, you said that you''d give me ' num2str(nChannels) ...
	       'channels but you gave me ' num2str(nChannelsGiven) ' instead']);
end

for(i = [1:nChannels])
	Signal = EEG_set_channel(Signal, eegChannels(i, :), eegData(i, :));
end

