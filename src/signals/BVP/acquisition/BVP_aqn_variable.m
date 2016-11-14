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
%> @file BVP_aqn_variable.m
%> @brief BVP_aqn_variable gets a BVP signal from a variable
% 
%> @param   rawBVP [1xN]: the raw BVP signal
%> @param    sampRate [1x1]: the sampling rate, in Hz
% 
%> @retval   Signal: A BVP TEAP signal
% 
%> @author Copyright Frank Villaro-Dixon, 2014
function Signal = BVP_aqn_variable(rawBVP, sampRate)

if(nargin ~= 2)
	error('Usage: BVP_aqn_variable(rawBVP, sampRate)');
end


Signal = BVP__new_empty();
Signal = Signal__set_samprate(Signal, sampRate);

Signal = Signal__set_raw(Signal, Raw_convert_1D(rawBVP));

%And we filter the signal. Else, it's useless
Signal = BVP_filter_basic(Signal); %FIXME: should this be done ? Or an option ?

end

