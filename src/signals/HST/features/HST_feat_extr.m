%> @file HST_feat_extr.m
%> @brief Computes Skin temperature features
%> @b WARNING: this function will give 'strange' results when applied on a relative
%>          signal

%> @param  HSTsignal the temperature  signal.
%> @param varargin you can choose which features to extract (see featureSelector)
%>            the list of available features is:
%>               - mean: average temprature
%>               - std: standard deviation of the temperature
%>               - kurtosis: Kurtosis of the temperature
%>               - skewness: skewness of the temperature

%> @retval HST_feats list of features values
%> @retval HST_feats_names names of the computed features (it is good pratice to
%>                   check this vector since the order of requested features
%>                   can be different than the requested one)
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2015


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

