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

%> @file EEG_feat_extr.m
%> @brief Computes Skin respiration features
%> @param  EEGsignal: the respiration  signal.
%> @param  varargin: you can choose which features to extract (see featureSelector)
%>            the list of available features is:
%>               - SP_delta:power spectral power for delta band <4Hz
%>               - SP_theta: power spectral power for theta band [4,8[ Hz
%>               - SP_slowAlpha: power spectral power for slow alpha band [8,[10 Hz
%>               - SP_alpha: power spectral power for alpha band [8,12[ Hz
%>               - SP_beta: power spectral power for beta band [12,30[ Hz
%>               - SP_gamma: power spectral power for gamma band >30Hz

%> @retval  EEG_feats: list of features values
%> @retval  EEG_feats_names: names of the computed features (it is good pratice to
%>                   check this vector since the order of requested features
%>                   can be different than the requested one)
%>               the  features are per electode and therefore  1xN (N= number of electrodes)
%>               and the final output is a 2dimensional array whose size is N_features x N_electrodes

%> @author Copyright Mohammad Soleymani, Guillaume Chanel, Frank Villaro-Dixon, BSD Simplified, 2015
function [EEG_feats, EEG_feats_names] = EEG_feat_extr(EEGsignal,varargin)

% Check inputs and define unknown values
narginchk(1, Inf);

%Make sure we have a EEG signal
EEGsignal = EEG__assert_type(EEGsignal);


if(Signal__get_absolute(EEGsignal) ~= true)
	warning('The signal was baselined/relative, are you sure you want that ?');
end


% Define full feature list and get features selected by user
featuresNames = {'SP_delta', 'SP_theta', 'SP_slowAlpha','SP_alpha','SP_beta','SP_gamma'};
EEG_feats_names = featuresSelector(featuresNames,varargin{:});
config_file;

%If some features are selected
if(~isempty(EEG_feats_names))
	if any(strncmp('SP',EEG_feats_names,2))
		%calculating spectral power features in different bands
		[SP_delta, SP_theta, SP_slowAlpha, SP_alpha, SP_beta, SP_gamma] = EEG_feat_bandENR(EEGsignal);
	end
	%final vector output
	for (i = 1:length(EEG_feats_names))
		eval(['EEG_feats(i,:) = ' EEG_feats_names{i} ''';']);
	end

else %no features selected
	EEG_feats = [];
end



