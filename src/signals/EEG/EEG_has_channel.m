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
%> @file EEG_has_channel.m
%> @brief Simply tells you if that specific channel on the @b EEG signal exists.
% 
%> @param  EEGSignal: the EEG signal
%> @param  channelName: the channelName (ex: 'Fp1')
% 
%> @retval  ChannelExists: a boolean variable
% 
%> @author Copyright Frank Villaro-Dixon, 2014
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

