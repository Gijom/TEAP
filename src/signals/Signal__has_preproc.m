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
%> @file Signal__has_preproc.m
%> @brief Has the given signal been through this preprocessing step
%> @param  Signal: the signal
%> @param preprocName: the pre-processing you want
%> @retval  Boolean: a boolean value indicating if yes (1) or no (you guessed-it)
%
%> @author Copyright Frank Villaro-Dixon, 2014
function Boolean = Signal__has_preproc(Signal, preprocName)

%Does the signal have some preprocessing done ?
if(~isfield(Signal, 'preprocessing')) %No preprocessing whatsoever
	Boolean = false;
	return;
end

%Does it have the feature:
if(~isfield(Signal.preprocessing, preprocName))
	Boolean = false;
	return;
end

Boolean = true;

%!assert(Signal__has_preproc(Signal__new_empty(), 'oauoau'), false);

%!test
%! sig = Signal__new_empty();
%! sig = Signal__set_preproc(sig, 'aoeu');
%! assert(Signal__has_preproc(sig, 'aoeu'), true);
%! assert(Signal__has_preproc(sig, 'htns'), false);
