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
% 
%> @file EEG_set_channel.m
%> @brief Sets the channel 'channelName' of the EEG signal
% 
%> @param  Signal: the EEG signal
%> @param  channelName: the name of the channel (ex: 'AF3')
%> @param  channelData: the data
% 
%> @retval  Signal The set signal
% 
%> @author Copyright Frank Villaro-Dixon, 2014
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


