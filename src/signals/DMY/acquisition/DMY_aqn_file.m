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

%> @file DMY_aqn_file.m
function Signal = DMY_aqn_file(filename)
% DMY_AQN_FILE gets a DMY signal from a filename

Signal = DMY_new_empty();
Signal = Signal__set_samprate(10); %Hz
Signal = Signal__set_raw(rand(1, 60));


end

