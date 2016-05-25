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

%> @file Signal__assert_mine.m
%> @brief Asserts that the signal is a TEAPhysio one

%> @param  Signal: the signal to test

%> @author Copyright Frank Villaro-Dixon, 2014
function Signal__assert_mine(Signal)

if(nargin ~= 1)
	error('Usage: Signal__assert_mine(Signal)');
end

%TODO: implement the display of a bulk ?
if(length(Signal) == 1) %Avoid multiple bulk case for instance
    if(isfield(Signal, 'TEAPhysio'))
        if(Signal.TEAPhysio == 'S')
            return;
        end
    end
end

error('The signal given is not a TEAPhysio one')

%!error(Signal__assert_mine(42))
%!error(Signal__assert_mine())

