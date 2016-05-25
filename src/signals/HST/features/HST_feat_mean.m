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

%> @file HST_feat_mean.m
%> @brief Computes the mean of the HST signal (aka the mean temperature)
%> @b WARNING: this function will give 'strange' results when applied on a relative
%> signal
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014

%> @param HSTsignal the HST signal.

%> @retval meanTemp the mean temperature, in °C

function [meanTemp] = HST_feat_mean(HSTsignal)

%Make sure we have a HST signal
HSTsignal = HST__assert_type(HSTsignal);


if(~Signal__has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a mean filter']);
end

if(Signal__get_absolute(HSTsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end

raw = Signal__get_raw(HSTsignal);

meanTemp = mean(raw);


