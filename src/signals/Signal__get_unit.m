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
%> @file Signal__get_unit.m
%> @brief Gets the unit of a signal (ex: 'Ohm' for a GSR signal)
%> @param  Signal: the signal
%> @retval  unit: a string naming the unit
%
%> @author Copyright Frank Villaro-Dixon, 2014
function unit = Signal__get_unit(Signal)

if(nargin ~= 1)
	error('Usage: unitName = Signal__get_unit(Signal)');
end

Signal__assert_mine(Signal);

unit = Signal.unit;

%!error(Signal__get_unit())
%!error(Signal__get_unit(42))

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_unit(sig, 'tu');
%! assert(Signal__get_unit(sig), 'tu');
