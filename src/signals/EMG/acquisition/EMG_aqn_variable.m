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

%> @file EMG_aqn_variable.m
%> @brief EMG_aqn_variable gets an EMG signal from a variable
%> @b USAGE:
%> If you've got the signal from the 2 electrodes, you must call the function
%> like that:
%> @code
%>  EMG_aqn_variable(electrode1, electrode2, sampRate);
%> @endcode
%> If, however, the difference was already calculated by your device, you can
%> call the function that way:
%> @code
%>  EMG_aqn_variable(electrodesDiff, sampRate);
%> @endcode
%
%> @param   EMG [1xN]:  the EMG signal
%> @param   EMG2 [1xN]: the other pair EMG signal (optional if difference already calc.)
%> @param   sampRate [1x1]: the sampling rate, in Hz

%> @retval Signal An EMG TEAPhysio signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = EMG_aqn_variable(EMG, EMG2, sampRate)

Signal = EMG__new_empty();

if(nargin == 2) %second case
	sampRate = EMG2;
	raw = EMG;
elseif(nargin == 3) %first case
	raw = EMG2 - EMG;
else
	error('Usage: EMG_aqn_variable(EMG [, EMG2], sampRate)');
end

Signal = Signal__set_samprate(Signal, sampRate);
Signal = Signal__set_raw(Signal, raw);

end

