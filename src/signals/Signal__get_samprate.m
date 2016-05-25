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

%> @file Signal__get_samprate.m
%> @brief Returns the sampling rate of a signal

%> @param  Signal: the signal you want to get the sampling rate

%> @retval  samprate: the sampling rate of the signal, in hertz
%
%> @author Copyright Frank Villaro-Dixon, 2014
function samprate = Signal__get_samprate(Signal)

if(nargin ~= 1)
	error('Usage: samprate = Signal__get_samprate(Signal)');
end

Signal__assert_mine(Signal);

samprate = Signal.samprate;

%!error(Signal__get_samprate());
%!error(Signal__get_samprate(42));

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_samprate(sig, 42);
%! assert(Signal__get_samprate(sig), 42);
