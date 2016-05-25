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

%> @file Signal__get_offset.m
%> @brief Gets the offset(in frames) relative to its parent (the first it had, non recursive).
%> @param  Signal: the signal you want to know the offset
%> @retval  offset: the signal offset, in frames
%
%> @attention SEE ALSO:
%>  - @c Signal__get_window
%>  - @c Signal__get_window_frames
%>
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function offset = Signal__get_offset(Signal)

if(nargin ~= 1)
	error('Usage: offset = Signal__get_offset(Signal)');
end

Signal__assert_mine(Signal);

if(isfield(Signal, 'relatime'))
	offset = Signal.relatime;
else
	offset = 0;
end

%!assert(Signal__get_offset(Signal__new_empty()), 0)

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_samprate(sig, 1);
%! assert(Signal__get_offset(Signal__get_window(sig, 10, 20)), 10);
