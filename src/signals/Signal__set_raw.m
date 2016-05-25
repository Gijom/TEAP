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

%> @file Signal__set_raw.m
%> @brief Sets the raw data of the signal S
function Signal = Signal__set_raw(Signal, raw)

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_raw(Signal, raw)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end

Signal__assert_mine(Signal);

Signal.raw = double(raw);

%!error(Signal__set_raw())
%!error(Signal__set_raw(42))
%!error(Signal__set_raw(42, [1 2 3 4]))
%!error(Signal__set_raw(Signal__new_empty(), [1 2 3 4])) %No result retreived
%!assert(Signal__set_raw(Signal__new_empty(), [1 2 3 4]).raw, [1 2 3 4])

