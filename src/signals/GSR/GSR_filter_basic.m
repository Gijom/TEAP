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
%> @file GSR_filter_basic.m
%> @brief Cleans a signal adding a low-pass mean filter to it. The window equals the
%> sample rate, aka 1 sec.
% 
%> @param  GSRsignal: the GSR signal.
%> @retval  Signal: the filtered GSR signal
% 
%> @author Copyright Frank Villaro-Dixon, 2014
function GSRsignal = GSR_filter_basic(GSRsignal)


%Make sure we have a GSR signal
GSRsignal = GSR__assert_type(GSRsignal);

sampRate = Signal__get_samprate(GSRsignal);

if (sampRate < 32)
    warning(
        sprintf('Basic GSR filter cannot be applied because provided sampling frequency %d  <  32\n Either increase the sampling frequency or apply your own filter.', sampRate)
    );
else
    GSRsignal = Signal_filter1_low_mean(GSRsignal, round(sampRate/16));
end
