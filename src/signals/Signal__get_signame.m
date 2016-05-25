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

%> @file Signal__get_signame.m
%> @brief Gets the name of a signal, eg: 'GSR' for a Galvanic Skin Response signal
%> @param  Signal: the signal you want to get the name of.
%> @retval  signalName: the name of the signal (ex: 'GSR')
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function signalName = Signal__get_signame(Signal)


if(nargin ~= 1)
	error('Usage: signalName = Signal__get_signame(Signal)');
end

Signal__assert_mine(Signal);


if(~isfield(Signal, 'name'))
	error('Signal given is not a TEAPhysio signal')
end

signalName = Signal.name;

%!assert(strcmp(Signal__get_signame(Signal__new_empty()), 'invalid'))

