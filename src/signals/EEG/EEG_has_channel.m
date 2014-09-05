function ChannelExists = EEG_has_channel(EEGSignal, channelName)
%Simply tells you if that specific channel on the EEG signal exists.
% Inputs:
%  EEGSignal: the EEG signal
%  channelName: the channelName (ex: 'Fp1')
% Outputs:
%  ChannelExists: a boolean variable
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

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

