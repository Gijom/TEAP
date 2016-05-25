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

%> @file EMG_feat_extr.m
%> @brief Computes Skin EMG featuEMG
%> @param  EMGsignal: the EMG  signal.
%> @param  varargin: you can choose which features to extract (see featureSelector)
%>			the list of available features is:
%>			   - mean_: average temprature
%>			   - std_: standard deviation of the EMG
%>			   - kurtosis_: Kurtosis of the EMG
%>			   - skewness_: skewness of the EMG
%>			   - EMG_power: power spectral power above 20Hz

%> @retval  EMG_feats: list of featuEMG values
%> @retval EMG_feats_names: names of the computed features (it is good pratice to
%>						  check this vector since the order of requested features
%>						  can be different than the requested one)
%> @author Copyright Frank Villaro-Dixon, 2015

%
%> @b WARNING: this function will give 'strange' results when applied on a relative
%>		  signal
%
function [EMG_feats, EMG_feats_names] = EMG_feat_extr(EMGsignal, varargin)

% Check inputs and define unknown values
narginchk(1, Inf);

%Make sure we have a EMG signal
EMGsignal = EMG__assert_type(EMGsignal);


% Define full feature list and get featuEMG selected by user
featuEMGNames = {'mean_', 'std_', 'kurtosis_','skewness_','EMG_power'};
EMG_feats_names = featuresSelector(featuEMGNames,varargin{:});

%If some featuEMG are selected
if(~isempty(EMG_feats_names))
	samprate = Signal__get_samprate(EMGsignal);
	%statistical moments
	if any(strcmp('mean_',EMG_feats_names)) || any(strcmp('std_',EMG_feats_names)) || any(strcmp('kurtosis_',EMG_feats_names)) || any(strcmp('skewness_',EMG_feats_names))
		[mean_,std_, kurtosis_, skewness_] = Signal_feat_stat_moments(EMGsignal);
	end
	%EMG power above 20Hz; this is associated with muscule contractions
	if any(strcmp('EMG_power',EMG_feats_names))
		bands = [20,samprate/2];
		EMG_power = Signal_feat_bandEnergy(EMGsignal, bands)';
	end

	%Write the values to the final vector output
	for (i = 1:length(EMG_feats_names))
		eval(['EMG_feats(i,:) = ' EMG_feats_names{i} ';']);
	end

else %no featuEMG selected
	EMG_feats = [];
end

