%> @brief Sets the channel 'channelName' of the EEG signal

%> @param  Signal: the EEG signal
%> @param  channelName: the name of the channel (ex: 'AF3')
%> @param  channelData: the data

%> @retval  Signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = EEG_set_channel(Signal, channelName, channelData)

if(nargin ~= 3 || nargout ~= 1)
	error('Usage: Signal = EEG_set_channel(Signal, channelName, channelData)');
end

if(length(channelName) < 2)
	error('The name should be a string, like ''AF3''');
end

raw = Signal__get_raw(Signal);

raw.(channelName) = channelData;

Signal.raw = raw; %nasty hack; little exception cos double() in Signal__set_raw will fail
%%Signal = Signal__set_raw(Signal, raw);


