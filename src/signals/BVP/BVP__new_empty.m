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
%> @file BVP__new_empty.m
%> @brief Creates a new BVP empty signal
%> @retval Signal an empty @b BVP signal
function Signal = BVP__new_empty()

Signal = Signal__new_empty();
Signal = Signal__set_signame(Signal, BVP__get_signame());
Signal = Signal__set_unit(Signal, 'undef');

%Create IBI information. TODO ?
Signal.IBI = Signal__new_empty(); %Inter beat interval (empty if not computed) a vector otherwise
Signal.IBI = Signal__set_signame(Signal.IBI, 'IBI');
Signal.IBI = Signal__set_unit(Signal.IBI, 's'); %For the moment the user cannot choose it
Signal.IBI = Signal__set_samprate(Signal.IBI, 8); %For the moment the user cannot choose it
