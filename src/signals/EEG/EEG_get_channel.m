function Data = EEG_get_channel(Signal, channelName)
%Gets the channel data from the EEG signal
% Inputs:
%  Signal: the signal
%  channelName: the name of the channel you want to take
% Outputs:
%  Data: the data of the channel
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

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


