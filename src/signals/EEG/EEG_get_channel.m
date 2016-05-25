%This file is part of TEAP.
%
%TEAP is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%TEAP is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with TEAP.  If not, see <http://www.gnu.org/licenses/>.

%> @file EEG_get_channel.m
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


