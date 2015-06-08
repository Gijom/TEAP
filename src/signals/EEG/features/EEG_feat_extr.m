function [EEG_feats, EEG_feats_names] = EEG_feat_extr(EEGsignal,varargin)
%Computes Skin respiration features
% Inputs:
%  EEGsignal: the respiration  signal.
%  varargin: you can choose which features to extract (see featureSelector)
%            the list of available features is:
%               - SP_delta:power spectral power for delta band <4Hz
%               - SP_theta: power spectral power for theta band [4,8[ Hz
%               - SP_slowAlpha: power spectral power for slow alpha band [8,[10 Hz
%               - SP_alpha: power spectral power for alpha band [8,12[ Hz
%               - SP_beta: power spectral power for beta band [12,30[ Hz
%               - SP_gamma: power spectral power for gamma band >30Hz

% Outputs:
%  EEG_feats: list of features values
%  EEG_feats_names: names of the computed features (it is good pratice to
%                   check this vector since the order of requested features
%                   can be different than the requested one)
%               the  features are per electode and therefore  1xN (N= number of electrodes)
%               and the final output is a 2dimensional array whose size is N_features x N_electrodes

%Copyright Mohammad Soleymani, Guillaume Chanel, Frank Villaro-Dixon, BSD Simplified, 2015

% Check inputs and define unknown values
narginchk(1, Inf);
%
% WARNING: this function will give 'strange' results when applied on a relative
%          signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%Make sure we have a EEG signal
EEGsignal = EEG__assert_type(EEGsignal);


if(Signal__get_absolute(EEGsignal) ~= true)
    warning('The signal was baselined/relative, are you sure you want that ?');
end


% Define full feature list and get features selected by user
featuresNames = {'SP_delta', 'SP_theta', 'SP_slowAlpha','SP_alpha','SP_beta','SP_gamma'};
EEG_feats_names = featuresSelector(featuresNames,varargin{:});
config_file;
n_electrodes = length(electrode_labels.EEG);
%If some features are selected
if(~isempty(EEG_feats_names))    
    if any(strncmp('SP',EEG_feats_names,2))       
        %calculating spectral power features in different bands
        [SP_delta, SP_theta, SP_slowAlpha, SP_alpha, SP_beta, SP_gamma] = EEG_feat_bandENR(EEGsignal);
    end        
    %final vector output
    for (i = 1:length(EEG_feats_names))
        eval(['EEG_feats(i,:) = ' EEG_feats_names{i} '''';]);
    end
    
else %no features selected
    EEG_feats = [];
end



