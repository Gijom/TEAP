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

%> @file Signal__get_raw.m
%> @brief Returns the raw data of the signal
%> @param  Signal: the signal you want the raw data of
%> @retval  Raw: the raw data of the signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Raw = Signal__get_raw(Signal)

if(nargin ~= 1)
	error('Usage: Signal__get_raw(Signal)');
end

Signal__assert_mine(Signal);

Raw = Signal.raw;

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_raw(sig, [1 2 3 4]);
%! assert(Signal__get_raw(sig), [1 2 3 4]);
