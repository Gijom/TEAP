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

%> @file RES_filter_basic.m
%> @brief Cleans a signal adding a low-pass mean filter to it. The window equals the
%> sample rate, aka 1 sec.

%> @param RESsignal: the RES signal.

%> @retval Signal: the filtered RES signal

%> @author Copyright Frank Villaro-Dixon, 2014
function RESsignal = RES_filter_basic(RESsignal)


%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);

sampRate = Signal__get_samprate(RESsignal);

RESsignal = Signal_filter1_low_mean(RESsignal, round(sampRate/16));
