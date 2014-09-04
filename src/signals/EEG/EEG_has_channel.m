function ChannelExists = EEG_has_channel(EEGSignal, channelName)
%Simply tells you if that specific channel on the EEG signal exists.
% Inputs:
%  EEGSignal: the EEG signal
%  channelName: the channelName (ex: 'Fp1')
% Outputs:
%  ChannelExists: a boolean variable
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: ChannelExists = EEG_has_channel(EEGSignal, channelName)');
end

EEG_assert_mine(EEGSignal);

raw = Signal__get_raw(EEGSignal);

if(isfield(raw, channelName))
	ChannelExists = true;
else
	ChannelExists = false;
end

