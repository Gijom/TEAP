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

%> @file ECG_aqn_variable.m
%> @brief ECG_aqn_variable gets an ECG signal from a variable
%> @attention USAGE:
%> If you've got the signal from the 2 electrodes, you must call the function
%> like that:
%>  @c ECG_aqn_variable(electrode1, electrode2, sampRate);
%> If, however, the difference was already calculated by your device, you can
%> call the function that way:
%>  @c ECG_aqn_variable(electrodesDiff, sampRate);

%> @param   ECG [1xN]:  the ECG signal
%> @param   ECG2 [1xN]: the other pair ECG signal (optional if difference already calc.)
%> @param   sampRate [1x1]: the sampling rate, in Hz

%> @retval   Signal: An ECG TEAPhysio signal

%> @author Copyright Frank Villaro-Dixon, 2014
function Signal = ECG_aqn_variable(ECG, ECG2, sampRate)

Signal = ECG__new_empty();

if(nargin == 2) %second case
	sampRate = ECG2;
	raw = ECG;
elseif(nargin == 3) %first case
	raw = ECG2 - ECG;
else
	error('Usage: ECG_aqn_variable(ECG [, ECG2], sampRate)');
end

Signal = Signal__set_samprate(Signal, sampRate);
Signal = Signal__set_raw(Signal, raw);

end

