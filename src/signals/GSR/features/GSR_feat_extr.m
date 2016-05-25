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

%> @file GSR_feat_extr.m
%> @brief Computes GSR features

%> @param  GSRsignal: the GSR signal.
%> @param  varargin: you can choose which features to extract (see featureSelector)
%>            the list of available features is:
%>               - nbPeaks: number of GSR peaks per second
%>               - ampPeaks: average amplitude of peaks
%>               - riseTime: average rise time of peaks
%>               - meanGSR: average GSR value
%>               - stdGSR: variance of GSR

%> @retval  GSR_feats: list of features values
%> @retval  GSR_feats_names: names of the computed features (it is good pratice to
%>                   check this vector since the order of requested features
%>                   can be different than the requested one)
%> @author Copyright XXX 2011
%> @author Copyright Frank Villaro-Dixon, 2014
function [GSR_feats, GSR_feats_names] = GSR_feat_extr(GSRsignal,varargin)

% Check inputs and define unknown values
narginchk(1, Inf);

%Check signals and get sample rate
GSRsignal = GSR__assert_type(GSRsignal);
if(~Signal__has_preproc_lowpass(GSRsignal))
    warning(['For the function to work well, you should low-pass the signal' ...
            '. Preferably with a median filter']);
end
samprate = Signal__get_samprate(GSRsignal);

% Define full feature list and get features selected by user
featuresNames = {'nbPeaks', 'ampPeaks', 'riseTime','meanGSR','stdGSR'};
GSR_feats_names = featuresSelector(featuresNames,varargin{:});
if strcmp(GSRsignal.unit,'Ohm')
    ampThresh = 100;%Ohm
elseif strcmp(GSRsignal.unit,'nS')
    %convert to resistance ohm
    GSRsignal.raw = 1./(GSRsignal.raw*10E9);
    ampThresh = 100;%Ohm
else
    error('The GSR unit is unknows; please fix it - a threshold shall be adjusted to the unit')
end

%If some features are selected
if(~isempty(GSR_feats_names))
    
    if any(strcmp('nbPeaks',GSR_feats_names)) || any(strcmp('ampPeaks',GSR_feats_names)) || any(strcmp('riseTime',GSR_feats_names))
        
        [nbPeaks, ampPeaks, riseTime, posPeaks] = GSR_feat_peaks(GSRsignal,ampThresh);
        nbPeaks = nbPeaks/(length(GSRsignal)/samprate);
        ampPeaks = mean(ampPeaks);
        riseTime = mean(riseTime);
        %TODO what is this good for? posPeaks
    end
    
    %mean computation
    if any(strcmp('meanGSR',GSR_feats_names))
        meanGSR = Signal_feat_mean(GSRsignal);
    end
    
    %variance computation
    if any(strcmp('stdGSR',GSR_feats_names))
        stdGSR = Signal_feat_std(GSRsignal);
    end
    
    %Write the values to the final vector output
    for (i = 1:length(GSR_feats_names))
        eval(['GSR_feats(i) = ' GSR_feats_names{i} ';']);
    end
    
else %no features selected
    GSR_feats = [];
end

end

