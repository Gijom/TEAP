%> @brief Gets the channel data from the EEG signal

%> @param  Signal: the signal
%> @param  channelName: the name of the channel you want to take

%> @retval  Data: the data of the channel

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Data = EEG_get_channel(Signal, channelName)

if(nargin ~= 2)
	error('Usage: Data = EEG_get_channel(Signal, channelName)');
end

Signal = EEG__assert_type(Signal);

if(~isfield(Signal__get_raw(Signal), channelName))
	error(['Sorry, but I don''t have the channel that you wanted (' ...
	       channelName ')']);
end

raw = Signal__get_raw(Signal);
Data = raw.(channelName);


