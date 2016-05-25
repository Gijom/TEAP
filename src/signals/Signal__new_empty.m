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

%> @file Signal__new_empty.m
%> @brief Creates a new, empty, signal. This is mainly to represent the data structure
%> @retval  Signal: an empty signal
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function Signal = Signal__new_empty()

Signal.TEAPhysio = 'S'; %'S' because it is a signal. May have been 'B' for Bulk

%The sampling rate of the signal
Signal = Signal__set_samprate(Signal, -1);

%The raw data of the signal
Signal = Signal__set_raw(Signal, []);

%The unit of the signal (eg: °C, etc.)
Signal = Signal__set_unit(Signal, 'no unit');

%The name of the signal (eg: GSR)
Signal = Signal__set_signame(Signal, 'invalid');

%Was the signal NOT normalized/'baselined' ?
Signal = Signal__set_absolute(Signal, true);


