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

%> @file Signal__set_samprate.m
%> @brief Sets the sampling rate of a signal
%> @param  Signal: the signal
%> @param  samprate: the sampling rate
%> @retval  Signal: the newly modified signal
%
%> @author Copyright Frank Villaro-Dixon, 2014
function Signal = Signal__set_samprate(Signal, samprate)

if(nargin ~= 2)
	error('Usage: Signal__set_samprate(Signal, samprate)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal__assert_mine(Signal);


Signal.samprate = samprate;

%!error(Signal__set_samprate())
%!error(Signal__set_samprate(42))
%!error(Signal__set_samprate(42, 43))
%!error(Signal__set_samprate(Signal__new_empty(), 42)) %result not retrieved
%!assert(Signal__get_samprate(Signal__set_samprate(Signal__new_empty(), 42)), 42)

