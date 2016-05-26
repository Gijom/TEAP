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

%> @file EEG_aqn_variable.m
%> @brief  EEG_aqn_variable gets an EEG signal from a variable.

%> @param   eegChannels [Cxstrings]: a vector specifying the C EEG channels given
%> @param   eegData [CxN]: a matrix containing the EEG data
%> @param   sampRate [1x1]: the sampling rate, in Hz

%> @retval   Signal: An EEG TEAP signal
function Signal = EEG_aqn_variable(eegChannels, eegData, sampRate)

if(nargin ~= 3)
	error('Usage: Signal = EEG_aqn_variable(eegChannels, eegData, sampRate');
end


Signal = EEG__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

nChannels = length(eegChannels);
[nChannelsGiven, ~] = size(eegData);

if(nChannelsGiven ~= nChannels)
	error(['Hey, you said that you''d give me ' num2str(nChannels) ...
	       'channels but you gave me ' num2str(nChannelsGiven) ' instead']);
end

for(i = [1:nChannels])
	chaname = strtrim(eegChannels{i});
	Signal = EEG_set_channel(Signal, chaname, eegData(i, :));
end

