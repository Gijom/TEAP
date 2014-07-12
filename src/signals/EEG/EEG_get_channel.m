function Data = EEG_get_channel(Signal, channelName)
%Gets the channel data from the EEG signal
% Inputs:
%  Signal: the signal
%  channelName: the name of the channel you want to take
% Outputs:
%  Data: the data of the channel
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 2)
	error('Usage: Data = EEG_get_channel(Signal, channelName)');
end

EEG_assert_mine(Signal);

if(~isfield(Signal_get_raw(Signal), channelName)
	error(['Sorry, but I don''t have the channel that you wanted (' ...
	       channelName ')');
end

raw = Signal_get_raw(Signal);
Data = raw.(channelName);


