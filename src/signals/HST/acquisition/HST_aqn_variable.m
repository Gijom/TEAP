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

%> @file HST_aqn_variable.m
%> @brief HST_aqn_variable gets a HST signal from a variable

%> @param rawHST [1xN] the raw HST signal
%> @param sampRate [1x1] the sampling rate, in Hz
%> @retval Signal A HST TEAP signal

%> Copyright Frank Villaro-Dixon, 2014
function Signal = HST_aqn_variable(rawHST, sampRate)


if(nargin ~= 2)
	error('Usage: HST_aqn_variable(rawHST, sampRate)');
end

Signal = HST__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

if(median(rawHST) > 70)
	warning(['The signal given seems to be given in °F. I need °C ! ' ...
	         'Automatic conversion applied. ' ...
	         'And stop using Fahrenheit, nobody uses it anyway !']);
	rawHST = (rawHST - 32) .* (5/9);
end

if(median(rawHST) < 4 && median(rawHST) > -4) %we may have a relative signal
	Signal = Signal__set_absolute(Signal, false);
elseif(median(rawHST) < 20 || median(rawHST) > 45)
	error(['Something seems wrong with the HST signal: temperatures outside' ...
	       ' range (20; 54)']);
end


Signal = Signal__set_raw(Signal, Raw_convert_1D(rawHST));

%And, we filter the signal, else it's useless
Signal = HST_filter_basic(Signal);

