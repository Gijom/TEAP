function [RES_feats, RES_feats_names] = RES_feat_extr(RESsignal,varargin)
%Computes Skin respiration features
% Inputs:
%  RESsignal: the respiration  signal.
%  varargin: you can choose which features to extract (see featureSelector)
%            the list of available features is:
%               - mean_: average temprature
%               - std_: standard deviation of the respiration
%               - kurtosis_: Kurtosis of the respiration
%               - skewness_: skewness of the respiration
%               - main_freq: main frenquency of the respiration
%               - spxxyy: power spectral power between [xx,yy] /10 Hz
% Outputs:
%  RES_feats: list of features values
%  RES_feats_names: names of the computed features (it is good pratice to
%                   check this vector since the order of requested features
%                   can be different than the requested one)
%Copyright Frank Villaro-Dixon, BSD Simplified, 2015

% Check inputs and define unknown values
narginchk(1, Inf);
%
% WARNING: this function will give 'strange' results when applied on a relative
%          signal
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


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
    if any(strcmp('mean_',RES_feats_names)) || any(strcmp('std_',RES_feats_names)) || any(strcmp('kurtosis_',RES_feats_names)) || any(strcmp('skewness_',RES_feats_names))
        [mean_,std_, kurtosis_, skewness_] = Signal_feat_stat_moments(RESsignal);
    end
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
    if any(strcmp('main_freq',RES_feats_names))
        [main_freq] = RES_feat_mainfreq(RESsignal);
    end
    
    %Write the values to the final vector output
    for (i = 1:length(RES_feats_names))
        eval(['RES_feats(i) = ' RES_feats_names{i} ';']);
    end
    
else %no features selected
    RES_feats = [];
end



