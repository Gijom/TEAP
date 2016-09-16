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
%> @file GSR_aqn_variable.m
%> @brief GSR_aqn_variable gets a GSR signal from a variable
% 
%> @param   rawGSR [1xN]: the raw GSR signal
%> @param   sampRate [1x1]: the sampling rate, in Hz
% 
%> @retval   Signal: A GSR TEAP signal
% 
%> @author Copyright Frank Villaro-Dixon, 2014
function Signal = GSR_aqn_variable(rawGSR, sampRate)

if(nargin ~= 2)
	error('Usage: GSR_aqn_variable(rawGSR, sampRate)');
end


Signal = GSR__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

%If it is given in Siemens
if(min(rawGSR) >= 0 && max(rawGSR) < 1)
	warning(['The signal given seems to be given in Siemens. I need Ohms. ' ...
	         'Automatic conversion applied']);
	rawGSR = 1./rawGSR;
elseif(min(rawGSR) < 0) %if the signal was baselined/relatived
	Signal = Signal__set_absolute(Signal, false);
end


Signal = Signal__set_raw(Signal, Raw_convert_1D(rawGSR));

%And we filter the signal. Else, it's useless
Signal = GSR_filter_basic(Signal);

end

