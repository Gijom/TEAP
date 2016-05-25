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

%> @file Signal_filter1_low_mean.m
%> @brief Filters the signal with a low pass mean filtering

%> @param  Signal: the signal to filter. Not a bulk signal !
%> @param windowSize: the window size (in samples)

%> @retval Signal: the newly filtered signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal_filter1_low_mean(Signal, windowSize)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_mean(Signal, windowSize)');
end

Signal__assert_mine(Signal);


raw = Signal__get_raw(Signal);

filtAvgEls = ones(1, windowSize)/windowSize;
raw = filtfilt(filtAvgEls, 1, [repmat(raw(1), windowSize, 1); raw']);

raw = raw';

%take out first second
offset = windowSize + 1;
raw = raw(offset:end);
%and say that the signal was offseted by offset frames
Signal = Signal__set_offset(Signal, Signal__get_offset(Signal) + offset);

Signal = Signal__set_raw(Signal, raw);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);

