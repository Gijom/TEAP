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

%> @file Signal__set_preproc.m
%> @brief Set a preprocessing attribute for a signal. Ex: lowPass, highPass

%> @param  Signal: the signal
%> @param  preprocName: the name of the preprocessing calculus done

%> @retval  Signal: the modified signal

%> @author Copyright Frank Villaro-Dixon, 2014
function Signal = Signal__set_preproc(Signal, preprocName)

if(nargin ~= 2)
	error('Usage: Signal = Signal__set_preproc(Signal, preprocName)');
end

if(nargout ~= 1)
	error('You need to retrieve the function''s result. Else, it''s useless !');
end


Signal__assert_mine(Signal);

Signal.preprocessing.(preprocName) = true;


