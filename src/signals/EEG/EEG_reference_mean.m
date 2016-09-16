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
%> @file EEG_reference_mean.m
%> @brief re-references the @b EEG signals to their mean
%> Creates a reference for the @b EEG signal; removed average reference' the signal
% 
%> @param  EEGSignal: the @b EEG signal
%> @retval  EEGSignal: the referenced @b EEG signal
%
%> @author Copyright Frank Villaro-Dixon, 2014
function EEGSignal = EEG_reference_mean(EEGSignal)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: EEGSignal = EEG_reference_mean(EEGSignal);');
end

EEGSignal = EEG__assert_type(EEGSignal);

raw = Signal__get_raw(EEGSignal);

eMean = mean(cell2mat(struct2cell(raw)));

electrodes = fieldnames(raw);


for i = [1:length(electrodes)]
	%Take the signal we want
	electrode = EEG_get_channel(EEGSignal, electrodes{i});
	electrode = electrode - eMean;
	EEGSignal = EEG_set_channel(EEGSignal, electrodes{i}, electrode);
	%TODO: set up flag to say referenced
end
