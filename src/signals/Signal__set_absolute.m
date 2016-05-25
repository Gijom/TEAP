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

%> @file Signal__set_absolute.m
%> @brief Sets the data of the signal to absolute or relative
%>
%> Example: for a HST signal, do you have samples like [37, 37.5, 37.6] or more
%> like [0, 0.5, 0.6] ? If true, the data is absolute (37), if false, it is relative (0).

%> @param  Signal: the signal to set the flag
%> @param  isAbsolute: true/false

%> @retval  Signal: the same signal with the flag set
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [Signal] = Signal__set_absolute(Signal, isAbsolute) 

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal__set_absolute(Signal, isAbsolute)');
end

Signal.isAbsolute = isAbsolute;


