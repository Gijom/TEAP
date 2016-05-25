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

%> @file Signal__get_absolute.m
%> @brief Is the signal data absolute or relative ?
%> @param  Signal
%> @retval  isAbsolute: true/false depending on if it is absolute (true) or relative
%>              (false) data.
%
%> @attention SEE ALSO:
%> - Signal__set_absolute
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [isAbsolute] = Signal__get_absolute(Signal)

if(nargin ~= 1)
	error('Usage: isAbsolute = Signal__get_absolute(Signal)');
end

isAbsolute = Signal.isAbsolute;


