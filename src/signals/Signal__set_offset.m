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

%> @file Signal__set_offset.m
%> @brief Sets the offset of the specified signal
%> @param  Signal: the signal
%> @param  offset: the offset of the signal, in frames/samples
%> @retval Signal: the modified signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__set_offset(Signal, offset)

if(nargin ~= 2 || nargout ~= 1)
	error('Usage: Signal = Signal__set_offset(Signal, offset)');
end

Signal__assert_mine(Signal);

Signal.relatime = offset;


