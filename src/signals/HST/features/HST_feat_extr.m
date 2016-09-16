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
%> @file HST_feat_extr.m
%> @brief Computes Skin temperature features
%> @b WARNING: this function will give 'strange' results when applied on a relative
%>          signal
% 
%> @param  HSTsignal the temperature  signal.
%> @param varargin you can choose which features to extract (see featureSelector)
%>            the list of available features is:
%>               - mean_: average temprature
%>               - std_: standard deviation of the temperature
%>               - kurtosis_: Kurtosis of the temperature
%>               - skewness_: skewness of the temperature
%>               - sp0001: Spectral power 0-0.1Hz,
%>               - sp0102: Spectral power 0.1-0.2Hz,
% 
%> @retval HST_feats list of features values
%> @retval HST_feats_names names of the computed features (it is good pratice to
%>                   check this vector since the order of requested features
%>                   can be different than the requested one)
%> @author Copyright Frank Villaro-Dixon, 2015


function [HST_feats, HST_feats_names] = HST_feat_extr(HSTsignal,varargin)

% Check inputs and define unknown values
narginchk(1, Inf);

%Make sure we have a HST signal
HSTsignal = HST__assert_type(HSTsignal);


if(~Signal__has_preproc_lowpass(HSTsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	        '. Preferably with a mean filter']);
end

if(Signal__get_absolute(HSTsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end


% Define full feature list and get features selected by user
featuresNames = {'mean_', 'std_', 'kurtosis_','skewness_','sp0001', 'sp0102'};
HST_feats_names = featuresSelector(featuresNames,varargin{:});

%If some features are selected
if(~isempty(HST_feats_names))
	raw = Signal__get_raw(HSTsignal);
	%statistical moments
	if any(strcmp('mean_',HST_feats_names)) || any(strcmp('std_',HST_feats_names)) || any(strcmp('kurtosis_',HST_feats_names)) || any(strcmp('skewness_',HST_feats_names))
		[mean_,std_, kurtosis_, skewness_] = Signal_feat_stat_moments(HSTsignal);
	end
	%spectral power features in bands; these two bands are chosen due to
	%the low frequency content in this signal
	if any(strncmp('sp',HST_feats_names,2))
		bands = [0, 0.1; 0.1, 0.2];		
		[powerBands] = Signal_feat_bandEnergy(HSTsignal, bands);
		sp0001 = powerBands(1);
		sp0102 = powerBands(2);
	end
	%Write the values to the final vector output
	for (i = 1:length(HST_feats_names))
		eval(['HST_feats(i) = ' HST_feats_names{i} ';']);
	end
else %no features selected
	HST_feats = [];
end

