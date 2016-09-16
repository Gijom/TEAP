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
%> @file Signal__get_window.m
%> @brief Takes a portion of a signal between startT and endT seconds. NB: that the
%> child signal will memorize the offset to its father (the first-one, non recursive)
%> start: useful if you want to plot the signal with logical times.
%> If you want to specify frames (aka. samples) instead of seconds, you should
%> use @c Signal__get_window_frames()
% 
%> @param  Signal: the signal you want to take a portion of.
%> @param  startT: the start time (s)
%> @param  endT: the end time (s)
% 
%> @retval Signal: son signal
%
%> @attention SEE ALSO:
%> - Signal__get_window_frames
%> - Signal__get_offset
%
%> @author Copyright Frank Villaro-Dixon, 2014
function Child = Signal__get_window(Signal, startT, endT)


if(nargin ~= 3)
	error('Usage: ChildSig = Signal__get_window(Signal, startT, endT)');
end

Signal__assert_mine(Signal);


fs = Signal__get_samprate(Signal);

startTFrame = startT * fs;
endTFrame = endT * fs;

Child = Signal__get_window_frames(Signal, startTFrame, endTFrame);

%!error(Signal__get_window())
%!error(Signal__get_window(42))
%!error(Signal__get_window(42, 1))
%!error(Signal__get_window(42, 1, 2))

