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
%> @file PICtoBPM.m
%> @brief Computes BPM and IBI from a list of pics
%> @b Author: Guillaume Chanel

%> @param listePic list of samples containing a pic
%> @param fe sampling frequency

%> @retval bpm beat per minuts
%> @retval delta_t Interbeat intervals (IBI)
%> @retval sample (possibly 1/2 samples) at which the IBI is computed, this is
%>     in fact the average of the start and end beats samples (i.e. the HR
%>     considered to lies inbetween the two beats).
%> @author Guillaume Chanel
function [bpm delta_t t] = PICtoBPM(listePic, fe)

bpm =[];
t = [];
deltaSamp = [];
for(j=2:length(listePic))
	deltaSamp(j-1) = listePic(j)-listePic(j-1);
	if(deltaSamp(j-1) <= 0)
		error('L''ecart entre deux pic doit etre de 1 minimum');
	end
	bpm(j-1) = 60/(deltaSamp(j-1)*(1/fe));
	t(j-1) = mean([listePic(j-1) listePic(j)]);
end
delta_t = deltaSamp / fe;

