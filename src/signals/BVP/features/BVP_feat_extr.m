function [BVP_feats, BVP_feats_names] = BVP_feat_extr(BVPSignal,varargin)
%Computes BVP features
% Inputs:
%  BVPsignal: the BVP signal.
%  varargin: you can choose which features to extract (see featureSelector)
%  TODO update the list correctly
%            the list of available features is:
%           mean_: averaged BVP - ralated to blood pressure
%           HRV: heart rate variability calculated based on the standard
%           deviation IBI differences
%           HR: mean heart rate (beat per minute)
%           MSE: Multi-Scale Entropy at 5 levels 1-5
%           sp0001: spectral power in 0.0-0.1Hz band
%           sp0102: spectral power in 0.1-2.1Hz band
%           sp0203: spectral power in 0.2-3.1Hz band
%           sp0304: spectral power in 0.3-4.1Hz band
%           sp_energyRatio: spectral power ratio between 0.0-0.08Hz and
%           0.15-0.5Hz bands
%           tachogram_LFSP: Tachogram's low freqneucy spectral content
%           <0.08Hz
%           tachogram_MFSP: Tachogram's medium freqneucy spectral content
%           0.08Hz> and <0.15Hz
%           tachogram_HFSP: Tachogram's high freqneucy spectral content
%           0.15Hz> and <0.5Hz
%           tachogram_energy_ratio: energu ratio tachogram_MFSP/(tachogram_HSP+tachogram_LFSP)
% Outputs:
%  BVP_feats: list of features values
%  BVP_feats_names: names of the computed features (it is good pratice to
%                   check this vector since the order of requested features
%                   can be different than the requested one)
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

% Check inputs and define unknown values
narginchk(1, Inf);
%Make sure we have an BVP signal
BVPSignal = BVP__assert_type(BVPSignal);


% Define full feature list and get features selected by user
featuresNames = {'mean_', 'HRV', 'meanIBI', 'MSE',  ...
    'sp0001', 'sp0102', 'sp0203', 'sp0304', 'sp_energyRatio', ...
    'tachogram_LF', 'tachogram_MF', 'tachogram_HF', 'tachogram_energy_ratio'};
featuresNamesIBI = {'mean_', 'HRV', 'meanIBI', 'tachogram_LF', 'tachogram_MF', 'tachogram_HF', 'tachogram_energy_ratio'};
BVP_feats_names = featuresSelector(featuresNames,varargin{:});
%If some features are selected
if(~isempty(BVP_feats_names))
    
    %Compute the results
    
    %First compute IBI if needed by the requested features
    if(any(ismember(featuresNamesIBI,BVP_feats_names)))
        BVPSignal = BVP__compute_IBI( BVPSignal );
        IBI = Signal__get_raw(BVPSignal.IBI);
        IBI_sp = Signal__get_samprate(BVPSignal.IBI);
    end
    
    %Get the raw signals
    rawSignal = Signal__get_raw(BVPSignal);
    samprate = Signal__get_samprate(BVPSignal);
    %averaged BVP - ralated to blood pressure
    
    if any(strcmp('mean_',BVP_feats_names))
        mean_ = mean(rawSignal);
    end
    

    
    if any(strcmp('meanIBI',BVP_feats_names)) || any(strcmp('HRV',BVP_feats_names))
        HRV = std(IBI);
        meanIBI = mean(IBI);
    end
    if any(strncmp('MSE',BVP_feats_names,3))
        %multi-scale entropy for 5 scales on hrv
        [MSE] = multiScaleEntropy(IBI,5);
    end
    
    if any(strncmp('sp',BVP_feats_names,2))
        [P, f] = pwelch(rawSignal, [], [], [], samprate,'power');
        P=P/sum(P);
        %power spectral featyres
        sp0001 = log(sum(P(f>0.0 & f<=0.1))+eps);
        sp0102 = log(sum(P(f>0.1 & f<=0.2))+eps);
        sp0203 = log(sum(P(f>0.2 & f<=0.3))+eps);
        sp0304 = log(sum(P(f>0.3 & f<=0.4))+eps);
        sp_energyRatio = log(sum(P(f<0.08))/sum(P(f>0.15 & f<5))+eps);
    end
    
    %tachogram features; psd features on inter beat intervals
    %R. McCraty, M. Atkinson, W. Tiller, G. Rein, and A. Watkins, "The
    %effects of emotions on short-term power spectrum analysis of
    %heart rate variability," The American Journal of Cardiology, vol. 76,
    %no. 14, pp. 1089 -1093, 1995
    if any(strcmp('tachogram_LF',BVP_feats_names)) ...
            || any(strcmp('tachogram_MF',BVP_feats_names)) ||  any(strcmp('tachogram_HF',BVP_feats_names)) ...
            || any(strcmp('tachogram_energy_ratio',BVP_feats_names))
        [Pt, ft] = pwelch(IBI, [], [], [], IBI_sp,'power');
        clear tachogram %TODO: delete ? Why is it useful ?
        %WARN: check that this is possible with the IBI sampling rate
        %WARN: these values are sometimes negative because of the log, doesn't it appear as strange for a user ?
        tachogram_LF = log(sum(Pt(ft>0.01 & ft<=0.08))+eps);
        tachogram_MF = log(sum(Pt(ft>0.08 & ft<=0.15))+eps);
        tachogram_HF = log(sum(Pt(ft>0.15 & ft<=0.5))+eps);
        tachogram_energy_ratio = tachogram_MF/(tachogram_LF+tachogram_HF);
    end
    
    %Write the values to the final vector output
    BVP_feats = [];
    for (i = 1:length(BVP_feats_names))
        eval(['BVP_feats = cat(2, BVP_feats, ' BVP_feats_names{i} ');']);
    end
    
else %no features selected
    BVP_feats = [];
end
end
