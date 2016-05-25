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

%> @file Signal_filter1_low_median.m
%> @brief Filters the signal with a low pass median filtering method
%> @param Signal: the signal to filter. Not a bulk signal !
%> @param windowSize: the window size (in samples)

%> @retval  Signal: the newly filtered signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal_filter1_low_median(Signal, windowSize)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_median(Signal, windowSize)');
end

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

filtered = smooth(raw, windowSize);

Signal = Signal__set_raw(Signal, filtered);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);

