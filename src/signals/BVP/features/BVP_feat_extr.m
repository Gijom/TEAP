function [BVP_feats, BVP_feats_names] = BVP_feat_extr(BVPSignal,varargin)
%Computes BVP features
% Inputs:
%  BVPsignal: the BVP signal.
%  varargin: you can choose which features to extract (see featureSelector)
%            the list of available features is:
%           mean_: averaged BVP - ralated to blood pressure
%           IBIVar: variance of inter-beat-interval
%           HRV: heart rate variability calculated based on the standard
%           deviation of the successive IBI differences
%           HR: mean heart rate (beat per minute)
%           MSE1: Multi-Scale Entropy at 5 levels 1-5
%           MSE2: look at MSE1
%           MSE3: look at MSE1
%           MSE4: look at MSE1
%           MSE5: look at MSE1
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
featuresNames = {'mean_','IBIVar', 'HRV', 'HR', 'MSE1', 'MSE2', 'MSE3', 'MSE4','MSE5',  ... 
                  'sp0001', 'sp0102', 'sp0203', 'sp0304', 'sp_energyRatio', ... 
    'tachogram_LFSP', 'tachogram_MFSP', 'tachogram_HFSP', 'tachogram_energy_ratio'};
BVP_feats_names = featuresSelector(featuresNames,varargin{:});
%If some features are selected
if(~isempty(BVP_feats_names))
    
    %Compute the results
    
    rawSignal = Signal__get_raw(BVPSignal);
    samprate = Signal__get_samprate(BVPSignal);
    %averaged BVP - ralated to blood pressure
    if any(strcmp('mean_',BVP_feats_names))
        mean_ = mean(raw);
    end
    
    if any(strcmp('IBIVar',BVP_feats_names)) || any(strncmp('tachogram',BVP_feats_names,9)) ...
            || any(strcmp('HR',BVP_feats_names)) || any(strcmp('HRV',BVP_feats_names))
        newfs = 256; %Hz, as needed by rpeakdetect
        %getting the raw signal
        rawSignal = detrend(rawSignal);
        %detecting peaks
        [~, t, ~, R_index, ~, ~] = rpeakdetect(rawSignal', newfs);
        %correcting for the impossible peaks
        [BPM, IBI] = correctBPM(R_index, newfs);
        %varaince of Inter Beat Intervals (IBI) relate dto HRV
        IBIVar = var(IBI);
        %the standard deviation of the successive differences between IBI
        HRV = std(diff(IBI));
        %heart rate
        HR = mean(BPM);
    end
    if any(strncmp('MSE',BVP_feats_names,3))
        %multi-scale entropy for 5 scales on hrv
        [MSE] = multiScaleEntropy(IBI,5);
        for j = 1:5
            eval(['MSE' num2str(j) '=MSE(j);']);
        end
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
    if any(strncmp('tachogram',BVP_feats_names,9)) 
        tachogram = zeros(length(rawSignal),1);
        tachogram(1:round(t(1)*samprate)) = IBI(1);
        for i = 1:length(t)-1
            tachogram(round(t(i)*samprate):round(t(i+1)*samprate)) = IBI(i);
        end
        tachogram(round(t(end)*samprate):end) = IBI(end);
        [Pt, ft] = pwelch(tachogram, [], [], [], samprate,'power');
        clear tachogram
        tachogram_LFSP = log(sum(Pt(ft>0.01 & ft<=0.08))+eps);
        tachogram_MFSP = log(sum(Pt(ft>0.08 & ft<=0.15))+eps);
        tachogram_HFSP = log(sum(Pt(ft>0.15 & ft<=0.5))+eps);
        tachogram_energy_ratio = tachogram_MFSP/(tachogram_HFSP+tachogram_LFSP);
    end
    
    %Write the values to the final vector output
    for (i = 1:length(BVP_feats_names))
        eval(['BVP_feats(i) = ' BVP_feats_names{i} ';']);
    end
    
else %no features selected
    BVP_feats = [];
end
end
