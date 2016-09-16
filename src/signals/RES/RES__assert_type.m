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
%> @file RES__assert_type.m
%> @brief Makes sure that the given signal is a RES one
%> If you want to know more about that, please see Signal__assert_type's document…
function Signal = RES__assert_type(Signal)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = RES__assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, RES__get_signame());

