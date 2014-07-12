function Signal = EEG_set_channel(Signal, channelName, channelData)
%Sets the channel 'channelName' of the EEG signal
% Inputs:
%  Signal: the EEG signal
%  channelName: the name of the channel (ex: 'AF3')
%  channelData: the data
% Outputs:
%  Signal
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 3 || nargout ~= 1)
	error('Usage: Signal = EEG_set_channel(Signal, channelName, channelData)');
end

if(length(channelName) < 2)
	error('The name should be a string, like ''AF3');
end

raw = Signal_get_raw(Signal);

raw.(channelName) = channelData;

Signal = Signal_set_raw(raw);


