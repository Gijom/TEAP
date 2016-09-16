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
%> @file correctBPM.m
%> @b DEPENDANCIES :
%>   PICtoBPM : compute BPM from of vector of peaks
%>   Guillaume Chanel (thanks to Joep)
%>   4/09/2008
% 
%> @param listePic_in [1*N] : vector of peaks with position of peak in sample for each
%> peak ([1 8 20] 3 peaks at samples 1, 8 and 20)
%> @param fe  ampling frequency
%> @param thresh limit between two peaks for detection of miss or bad peak.
%> decreasing this limit will not always augment the number of
%> corrections (see First step, Decide which problems are true ones in the code)
% 
%> @retval bpm new computed bpm from the corrected list of peaks
%> @retval listPic corrected list of peaks

function [bpm, delta_t, t, listePic] = correctBPM(listePic_in, fe, thresh)
%WARN I am not sure but this might be an old version check that this
%corresponds to correctBPM3 in my codes


if(nargin < 3)
    thresh = 0.2;
end


listePic = listePic_in;

nbTP = 5; %number of time peak to look ahead

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First step : remove the bad peaks

%Find time between all two consecutive peaks
timePic = diff(listePic)./fe;

%Find potential problem by checking the change in duration between two
%peaks compared to the threshold
listePb = [];
medTP = zeros(1, length(timePic));
for(iTP = [nbTP+1:length(timePic)])
    medTP(iTP) = median(timePic([iTP-nbTP:iTP-1]));
    if(medTP(iTP) - timePic(iTP)> thresh) %Pb detected %%%%%%%%%%%%%
        listePb = [listePb iTP];
    end
end



%Decide wich problems are true ones (if the peak is removed does the remaining
%interval corresponds to the median of the precedent)
realPb = [];
for(iPb = [1:length(listePb)])
    if(timePic(listePb(iPb))+timePic(listePb(iPb)-1) < medTP(listePb(iPb)) + thresh)
        realPb = [realPb listePb(iPb)];
    end
end
listePic(realPb) = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Second step : add peak if needed

%Find time between all two consecutive peaks
timePic = diff(listePic)./fe;

%Find potential problem by checking the change in duration between two
%peaks compared to the threshold
listePb = [];
medTP = zeros(1, length(timePic));
for(iTP = [nbTP+1:length(timePic)])
    medTP(iTP) = median(timePic(iTP-nbTP:iTP-1));
    if(medTP(iTP) - timePic(iTP) < -thresh) %Pb detected
        listePb = [listePb iTP];
    end
end

%for each problem add the necessary number of peaks

nbAddTotal = 0;
for(iPb = [1:length(listePb)])
    nbAdd = round(timePic(listePb(iPb))/medTP(listePb(iPb)))-1;
    splAdd = (timePic(listePb(iPb)) / (nbAdd + 1))*fe;
    relativePos = round(cumsum(splAdd*ones(1, nbAdd))); %relative position of each new peak to the peak before missing ones
    listePic = [listePic(1:listePb(iPb)+nbAddTotal)  (relativePos + listePic(listePb(iPb)+nbAddTotal)) listePic(listePb(iPb)+nbAddTotal+1:end)];
    nbAddTotal = nbAddTotal + nbAdd;
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Finally recompute BPM from new pics
[bpm delta_t t]  = PICtoBPM(listePic, fe);

