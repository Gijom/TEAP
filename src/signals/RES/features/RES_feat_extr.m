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
%> @file RES_feat_extr.m
%> @brief Computes Skin respiration features
%> @param  RESsignal: the respiration  signal.
%> @param varargin: you can choose which features to extract (see featureSelector)
%>            the list of available features is:
%>               - mean_: average temprature
%>               - std_: standard deviation of the respiration
%>               - kurtosis_: Kurtosis of the respiration
%>               - skewness_: skewness of the respiration
%>               - main_freq: main frenquency of the respiration
%>               - spxxyy: power spectral power between [xx,yy] /10 Hz
%>                 available values are: 'sp0001', 'sp0102','sp0203', 'sp0304',
%>                                       'sp0407', 'sp0710','sp1025'
%> @retval  RES_feats: list of features values
%> @retval RES_feats_names: names of the computed features (it is good pratice to
%>                   check this vector since the order of requested features
%>                   can be different than the requested one)
%> @author Copyright Frank Villaro-Dixon, 2015
function [RES_feats, RES_feats_names] = RES_feat_extr(RESsignal,varargin)

% Check inputs and define unknown values
narginchk(1, Inf);
%
% WARNING: this function will give 'strange' results when applied on a relative
%          signal
%

%Make sure we have a RES signal
RESsignal = RES__assert_type(RESsignal);


if(~Signal__has_preproc_lowpass(RESsignal))
	warning(['For the function to work well, you should low-pass the signal' ...
	        '. Preferably with a mean filter']);
end

if(Signal__get_absolute(RESsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end


% Define full feature list and get features selected by user
featuresNames = {'mean_', 'std_', 'kurtosis_','skewness_','sp0001', ...
    'sp0102','sp0203', 'sp0304', 'sp0407', 'sp0710','sp1025',  'main_freq'};
RES_feats_names = featuresSelector(featuresNames,varargin{:});

%If some features are selected
if(~isempty(RES_feats_names))    
	%statistical moments
	if any(strcmp('mean_', RES_feats_names)) || any(strcmp('std_', RES_feats_names)) || any(strcmp('kurtosis_', RES_feats_names)) || any(strcmp('skewness_', RES_feats_names))
		[mean_,std_, kurtosis_, skewness_] = Signal_feat_stat_moments(RESsignal);
	end

	%spectral power features in differnet bands defined in bands
	% these bands are arbitrarily chosen based on the spectral content
	%you can change them to what you prefer
	if any(strncmp('sp',RES_feats_names,2))
		bands = [0, 0.1; 0.1, 0.2; 0.2,0.3;0.3, 0.4; 0.4, 0.7;0.7,1;1,2.5];

		[powerBands] = Signal_feat_bandEnergy(RESsignal, bands);
		sp0001 = powerBands(1);
		sp0102 = powerBands(2);
		sp0203 = powerBands(3);
		sp0304 = powerBands(4);
		sp0407 = powerBands(5);
		sp0710 = powerBands(6);
		sp1025 = powerBands(7);
	end

	%Main frequency of respiration rhythm
	if any(strcmp('main_freq', RES_feats_names))
		[main_freq] = RES_feat_mainfreq(RESsignal);
	end

	%Write the values to the final vector output
	for (i = 1:length(RES_feats_names))
		eval(['RES_feats(i) = ' RES_feats_names{i} ';']);
	end

else %no features selected
	RES_feats = [];
end



