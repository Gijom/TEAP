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

%> @file HST_filter_basic.m
%> @brief Cleans an HST signal using a low-pass mean filter. The window equals the sample
%> rate, aka 1sec
%> Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%> @param  HSTSignal the HST signal to filter

%> @retval HSTSignal the HST signal filtered
function HSTSignal = HST_filter_basic(HSTSignal)

HSTSignal = HST__assert_type(HSTSignal);

sampRate = Signal__get_samprate(HSTSignal);

HSTSignal = Signal_filter1_low_mean(HSTSignal, sampRate);

