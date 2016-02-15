%> @brief  EEG_aqn_variable gets an EEG signal from a variable.

%> @param   eegChannels [Cxstrings]: a vector specifying the C EEG channels given
%> @param   eegData [CxN]: a matrix containing the EEG data
%> @param   sampRate [1x1]: the sampling rate, in Hz

%> @retval   Signal: An EEG TEAPhysio signal
function Signal = EEG_aqn_variable(eegChannels, eegData, sampRate)

if(nargin ~= 3)
	error('Usage: Signal = EEG_aqn_variable(eegChannels, eegData, sampRate');
end


Signal = EEG__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

nChannels = length(eegChannels);
[nChannelsGiven, ~] = size(eegData);

if(nChannelsGiven ~= nChannels)
	error(['Hey, you said that you''d give me ' num2str(nChannels) ...
	       'channels but you gave me ' num2str(nChannelsGiven) ' instead']);
end

for(i = [1:nChannels])
	chaname = strtrim(eegChannels{i});
	Signal = EEG_set_channel(Signal, chaname, eegData(i, :));
end

