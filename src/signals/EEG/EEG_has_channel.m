%> @brief Simply tells you if that specific channel on the @b EEG signal exists.

%> @param  EEGSignal: the EEG signal
%> @param  channelName: the channelName (ex: 'Fp1')

%> @retval  ChannelExists: a boolean variable

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function ChannelExists = EEG_has_channel(EEGSignal, channelName)

if(nargin ~= 2)
	error('Usage: ChannelExists = EEG_has_channel(EEGSignal, channelName)');
end

EEG__assert_type(EEGSignal);

raw = Signal__get_raw(EEGSignal);

if(isfield(raw, channelName))
	ChannelExists = true;
else
	ChannelExists = false;
end

