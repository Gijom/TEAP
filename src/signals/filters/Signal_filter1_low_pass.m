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

%> @file Signal_filter1_low_pass.m
%> @brief A simple low-pass filter applyed to 1D signals (such as GSR, ECG, etc…).

%> @param Signal: the signal to filter (will use the .raw component). Not a bulk sig. !
%> @param cutOffFreq: the cutOff frequency of the filter

%> @retval Signal: the low-passed-signal

%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal_filter1_low_pass(Signal, cutOffFreq)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal_filter1_low_pass(Signal, cutOffFreq)');
end

Signal__assert_mine(Signal);


%Take the sampling frequency of the signal
Fs = Signal__get_samprate(Signal);

%The normalized cutOff freq
Wn = (2/Fs)*cutOffFreq;

%Make the filter
b = fir1(20, Wn, 'low', kaiser(21, 3));

rawSignal = Signal__get_raw(Signal);

newRaw = filter(b, 1, rawSignal);

Signal = Signal__set_raw(Signal, newRaw);

%Indicate that the signal has been filtered
Signal = Signal__set_preproc_lowpass(Signal);
