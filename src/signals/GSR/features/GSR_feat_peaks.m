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
%> @file GSR_feat_peaks.m
%> @brief Computes the number of peaks from a GSR signal. It is based on the analysis of
%> local minima and local maxima preceding the local minima.
% 
%> @param  GSRsignal: the GSR signal.
%> @param  ampThresh: the amplitude threshold in Ohms from which a peak is detected.
%>             Default is 100 Ohm
% 
%> @retval  nbPeaks: the # of peaks in the signal
%> @retval  ampPeaks [1xP]: the amplitude of the peaks (maxima - minima)
%> @retval  riseTime [1xP]: the duration of the rise time of each peak
%> @retval  posPeaks [1xP]: index of the detected peaks in the GSR signal
% 
%> @author Copyright XXX 2011
%> @author Copyright Frank Villaro-Dixon, 2014
function [nbPeaks, ampPeaks, riseTime, posPeaks] = GSR_feat_peaks(GSRsignal, ampThresh)


%Make sure we have a GSR signal
GSRsignal = GSR__assert_type(GSRsignal);

if(~Signal__has_preproc_lowpass(GSRsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	         '. Preferably with a median filter']);
end

if(nargin < 2)
	ampThresh = 100;%Ohm
end

if(nargin < 1)
	error('Usage: [nbPeaks, ampPeaks, riseTime, posPeaks, GSRsignal] = GSR_feat_peaks(GSRsignal, ampThresh)');
end

tThreshLow = 1;
tThreshUp  = 10;



%Search low and high peaks
%low peaks are the GSR appex reactions (highest sudation)
%High peaks are used as starting points for the reaction
GSR = Signal__get_raw(GSRsignal);
%GSR = detrend(GSR);
dN = diff(diff(GSR) <= 0);
idxL = find(dN < 0) + 1; %+1 to account for the double derivative
idxH = find(dN > 0) + 1;

samprate = Signal__get_samprate(GSRsignal);

%For each low peaks find it's nearest high peak and check that there is no
%low peak between them, if there is one, reject the peak (OR SEARCH FOR CURVATURE)
riseTime = []; %vector of rise time for each detected peak
ampPeaks = []; %vector of amplitude for each detected peak
posPeaks = []; %vector of final indexes of low peaks
for(iP = [1:length(idxL)])
	%get list of high peaks before the current low peak
	nearestHP = idxH(idxH < idxL(iP));

	%if no high peak before (first peak detected in the signal) do nothing
	if(~isempty(nearestHP))
		%Get nearest high peak
		nearestHP = nearestHP(end);

		%check if there is no other low peaks between the nearest high and
		%the current low peaks. If not the case then compute peak features
		if(~any((idxL > nearestHP) & (idxL < idxL(iP))))
			rt = (idxL(iP) - nearestHP)/samprate;
			amp = GSR(nearestHP) - GSR(idxL(iP));

			%if rise time and amplitude fits threshold then the peak is
			%considered and stored
			if((rt >= tThreshLow) && (rt <= tThreshUp) && (amp >= ampThresh))
				riseTime = [riseTime rt];
				ampPeaks = [ampPeaks amp];
				posPeaks = [posPeaks idxL(iP)];
			end
		end
	end
end

nbPeaks = length(posPeaks);

end

