function [ECG_features, ECG_feats_names] = ECG_feat_extr(ECGSignal,varargin)
%Computes  ECG features
%TODO: clarifiy the help
%TODO call on other simple function instead of having all the computation
%in one file
%ALSO try to find a way to update the bulk when the bulk is given in
%parameter (to avoid recomputation of IBI each time
%
% Inputs:
%  ECGSignal: the ECG signal (already subtracted from one lead)
%  varargin: you can choose which features to extract
% default or no input will result in extracting all the features
% Outputs:
%  ECG_features: vector of features among the following features
%1. 2. mean HRV, 3. mean heart rate,
%4-8. Multiscale entropy at 5 levels on HRV (5 feaures),
%9. Spectral power 0-0.1Hz,
%10. Spectral power 0.1-0.2Hz,
%11. Spectral power 0.2-0.3
%12. Spectral power 0.3-0.4Hz,
%13. Spectral energy ratio between f<0.08Hz/f>0.15Hz and f<5.0Hz
%14. Low frequency spectral power in tachogram (HRV)  [0.01-0.08Hz]
%15. Medium frequency spectral power in tachogram (HRV)  [0.08-0.15Hz]
%16. High frequency spectral power in tachogram (HRV)  [0.15-0.5Hz]
%17. Energy ratio for tachogram spectral content (MF/(LF+HF))
% ECG_feats_names: names of features corresponding to th ECG_features
% values

%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%Make sure we have an ECG signal
ECGSignal = ECG__assert_type(ECGSignal);

% Define full feature list and get features selected by user
featuresNames = {'HR', 'HRV','MSE','sp0001','sp0102','sp0103','sp0203','sp0304','energyRatio','LF','MF','HF',...
    'tachogram_energy_ratio'};
featuresNamesIBI = {'HR', 'HRV','MSE','energyRatio','LF','MF','HF','tachogram_energy_ratio'};
ECG_feats_names = featuresSelector(featuresNames,varargin{:});

%Compute the results
if(~isempty(ECG_feats_names))
    
    %Compute IBI if a features needing it is requested
    if(any(ismember(featuresNamesIBI,ECG_feats_names)))
        ECGSignal = ECG__compute_IBI( ECGSignal );
        IBI = Signal__get_raw(ECGSignal.IBI);
        IBI_sp = Signal__get_samprate(ECGSignal.IBI);
    end
    
    %Get information of ECG signal
    ECG = Signal__get_raw(ECGSignal);
    ECG_sp = Signal__get_samprate(ECGSignal);
    
    %
    if any(strcmp('HR',varargin)) || any(strcmp('HRV',varargin))
        HRV = std(IBI);
        HR = mean(BPM);
    end
    if any(strcmp('MSE',varargin))
        %multi-scale entropy for 5 scales on hrv
        [MSE] = multiScaleEntropy(IBI,5);
    end
    if any(any(strcmp('sp0001',varargin)) ...
            || any(strcmp('sp0102',varargin)) ||  any(strcmp('sp0103',varargin)) ...
            || any(strcmp('sp0203',varargin)) || any(strcmp('sp0304',varargin)) ...
            || any(strcmp('energyRatio',varargin))
        
        [P, f] = pwelch(ECG, [], [], [], ECG_sp,'power');
        P=P/sum(P);
        %power spectral featyres
        %WARN: check that this resolution is obrainable with the ECG sampling rate
        sp0001 = log(sum(P(f>0.0 & f<=0.1))+eps);
        sp0102 = log(sum(P(f>0.1 & f<=0.2))+eps);
        sp0203 = log(sum(P(f>0.2 & f<=0.3))+eps);
        sp0304 = log(sum(P(f>0.3 & f<=0.4))+eps);
        energyRatio = log(sum(P(f<0.08))/sum(P(f>0.15 & f<5))+eps);
    end
    %tachogram features; psd features on inter beat intervals
    %R. McCraty, M. Atkinson, W. Tiller, G. Rein, and A. Watkins, �The
    %effects of emotions on short-term power spectrum analysis of
    %heart rate variability,� The American Journal of Cardiology, vol. 76,
    %no. 14, pp. 1089 � 1093, 1995
    if any(strcmp('LF',varargin)) ...
            || any(strcmp('MF',varargin)) ||  any(strcmp('HF',varargin)) ...
            || any(strcmp('tachogram_energy_ratio',varargin))
        [Pt, ft] = pwelch(IBI, [], [], [], IBI_sp,'power');
        clear tachogram
        %WARN: check that this is possible with the IBI sampling rate
        LF = log(sum(Pt(ft>0.01 & ft<=0.08))+eps);
        MF = log(sum(Pt(ft>0.08 & ft<=0.15))+eps);
        HF = log(sum(Pt(ft>0.15 & ft<=0.5))+eps);
        tachogram_energy_ratio = MF/(LF+HF);
    end
    
    %Setup feature vector
    for i = 1:length(ECG_feats_names)
        eval(['ECG_features(i) = ' ECG_feats_names{i} ';']);
    end
else
    ECG_features = [];
end


end

