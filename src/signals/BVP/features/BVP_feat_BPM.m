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

%> @file BVP_feat_BPM.m
%> @brief Computes the BPM from a BVP signal

%> @param  BVPSignal: the BVP signal

%> @retval  BPM: the beats per minute
%
%> @author Copyright Mohammad Soleymani 2013
%> @author Copyright Frank Villaro-Dixon, 2014
function BPM = BVP_feat_BPM(BVPSignal)


%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);

data = Signal__get_raw(BVPSignal)';
fs = Signal__get_samprate(BVPSignal);


if(nargin < 3)
	methodPeak = 'max';
end

SizeWindow = round(fs/50);
data = data - mean(data);

%Filter the data
dataS = filtfilt(ones(1, SizeWindow)/SizeWindow, 1,
                 [repmat(data(1), SizeWindow, 1); data]);
dataS = dataS(SizeWindow+1:end);

diffS = diff(dataS);

%recherche des pics postif : deriv decroissante = 0
listePic = [];
for(iSpl = 1:length(diffS)-1)
	%si il y a une derive == 0 sur le dernier sample elle n'est pas prise en compte
	if((diffS(iSpl) > 0) && (diffS(iSpl+1) < 0))
		listePic = [listePic iSpl+(diffS(iSpl) / (diffS(iSpl) - diffS(iSpl+1)))];
	elseif((diffS(iSpl) == 0) && (diffS(iSpl+1) < 0))
		listePic = [listePic iSpl];
	end
end

%Sure to keep that ?
listePic = round(listePic);


%Procedure to keep only peaks that are separated by at least 0.5 seconds
%other are considered as the same peak and one of the two is selected
%according to the chosen method. Also peaks that lie alone in the
%first 0.5 seconds are removed (cannot determine which peak it is…)
limit = round(0.5*fs);

%Remove too early first peakS
if((listePic(1) < limit) && (listePic(2) - listePic(1) >= limit))
	listePic = listePic(2:end);
end

%remove other peaks
iPic = 1;
while(iPic <= length(listePic) - 1)
	%If two peaks are too close keep the one depending on the method
	if((listePic(iPic+1) - listePic(iPic)) < limit)
		[dummy, choice] = max([data(listePic(iPic)) data(listePic(iPic+1))]);

		if(choice == 1)
			listePic(iPic+1) = [];
		else
			listePic(iPic) = [];
		end
	else
		iPic = iPic + 1;
	end
end


if(length(listePic) < 2)
	error('There should be at least 2 peaks to detect');
end

%Compute bpm from the pic list
[BPM delta_t t] = PICtoBPM(listePic, fs);

%%%%%BPM = mean(BPM); %And take it's mean

end

