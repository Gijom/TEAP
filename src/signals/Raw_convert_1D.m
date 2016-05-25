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

%> @file Raw_convert_1D.m
%> @brief Takes a raw signal and reshapes-it into a good form (aka 1D horizontal signal,
%> [1xN];
function Raw = Raw_convert_1D(Raw)

[y, x] = size(Raw);

if(y ~= 1) %If somewhat vertical
	if(x ~= 1) %but also somewhat horizontal
		error('Signal should be a 1D vector')
	end
	%Auto reshape with warning
	Raw = reshape(Raw, 1, length(Raw));
	warning('Signal should be [1xN] (aka horizontal). Automaticly reshaped');
end



