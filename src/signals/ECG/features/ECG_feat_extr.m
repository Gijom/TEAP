%> @brief Computes  ECG features
%TODO: clarifiy the help
%TODO call on other simple function instead of having all the computation
%TODO: changes all any statement to all or ismember because I think it can
%lead to problems (variable computation while it should not compute it)
%in one file
%
% Inputs:
%> @param  ECGSignal: the ECG signal (already subtracted from one lead)
%> @param  varargin: you can choose which features to extract
%> default or no input will result in extracting all the features

%> @retval  ECG_features: vector of features among the following features
%> @retval  ECG_feats_names: the names of the features is the same order than in
%>                   'ECG_features'
%> @retval  Bulk: if the input to the function is a Bulk than the Bulk is returned
%>        with the updated ECG signal, including IBI. Otherwise NaN is
%>        returned
%>
%>TODO update feature names there
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

%> @author Copyright Guillaume Chanel 2013, 2015
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [ECG_features, ECG_feats_names, Bulk] = ECG_feat_extr(ECGSignal,varargin)

%Make sure we have an ECG signal and get the bulk for saving IBI (if needed)
[ECGSignal, Bulk] = ECG__assert_type(ECGSignal);
if(nargout < 3) %No bulk requested -> do not need to keep it
    Bulk = [];
end

% Define full feature list and get features selected by user
%TODO: confirm with Mohammad that the changes are ok (suppression of 'sp0103'
featuresNames = {'meanIBI', 'HRV','MSE','sp0001','sp0102','sp0203','sp0304','energyRatio','tachogram_LF','tachogram_MF','tachogram_HF',...
    'tachogram_energy_ratio'};
featuresNamesIBI = {'meanIBI', 'HRV','MSE','energyRatio','tachogram_LF','tachogram_MF','tachogram_HF','tachogram_energy_ratio'};
ECG_feats_names = featuresSelector(featuresNames,varargin{:});

%Compute the results
if(~isempty(ECG_feats_names))
    
    %Compute IBI if a features needing it is requested
    if(any(ismember(featuresNamesIBI,ECG_feats_names)))
        %Compute IBI
        ECGSignal = ECG__compute_IBI( ECGSignal );
        IBI = Signal__get_raw(ECGSignal.IBI);
        IBI_sp = Signal__get_samprate(ECGSignal.IBI);
        
        %Update the Bulk with the new ECG signal
        if(~isempty(Bulk))
            Bulk = Bulk_update_signal(Bulk, Signal__get_signame(ECGSignal), ECGSignal);
        end
    end
    
    %Get information of ECG signal
    ECG = Signal__get_raw(ECGSignal);
    ECG_sp = Signal__get_samprate(ECGSignal);
    %set the welch window size
    welch_window_size_ECG = ECG_sp* 20;
    welch_window_size_IBI= IBI_sp* 20;
    
    %meanIBI is computed
    if any(strcmp('meanIBI',ECG_feats_names)) || any(strcmp('HRV',ECG_feats_names))
        HRV = std(IBI);
        meanIBI = mean(IBI);
    end
    if any(strcmp('MSE',ECG_feats_names))
        %multi-scale entropy for 5 scales on hrv
        [MSE] = multiScaleEntropy(IBI,5);
    end
    if length(ECG)< welch_window_size_ECG +ECG_sp
        warning('singal to short for the welch size');
    end
    if length(ECG)< welch_window_size_ECG +1
        warning('singal to short for the welch size - PSD features cannot be calcualted');
        sp0001 = NaN;sp0102 = NaN;sp0203 = NaN; sp0304 = NaN;energyRatio = NaN;
    else
        if any(strcmp('sp0001',ECG_feats_names)) || any(strcmp('sp0102',ECG_feats_names)) ...
                || any(strcmp('sp0203',ECG_feats_names)) || any(strcmp('sp0304',ECG_feats_names)) ...
                || any(strcmp('energyRatio',ECG_feats_names))
            
            [P, f] = pwelch(ECG, welch_window_size_ECG, [], [], ECG_sp);
            P=P/sum(P);
            %power spectral featyres
            %WARN: check that this resolution is obrainable with the ECG sampling rate
            sp0001 = log(sum(P(f>0.0 & f<=0.1))+eps);
            sp0102 = log(sum(P(f>0.1 & f<=0.2))+eps);
            sp0203 = log(sum(P(f>0.2 & f<=0.3))+eps);
            sp0304 = log(sum(P(f>0.3 & f<=0.4))+eps);
            energyRatio = log(sum(P(f<0.08))/sum(P(f>0.15 & f<5))+eps);
        end
        if length(IBI)< welch_window_size_IBI +IBI_sp
            warning('singal to short for the welch size');
        end
        if length(IBI)< welch_window_size_IBI +1
            warning('singal to short for the welch size - PSD features cannot be calcualted');
            tachogram_LF = NaN;tachogram_MF = NaN;tachogram_HF = NaN;
            tachogram_energy_ratio = NaN;
        else
            %tachogram features; psd features on inter beat intervals
            %R. McCraty, M. Atkinson, W. Tiller, G. Rein, and A. Watkins, �The
            %effects of emotions on short-term power spectrum analysis of
            %heart rate variability,� The American Journal of Cardiology, vol. 76,
            %no. 14, pp. 1089 � 1093, 1995
            if any(strcmp('tachogram_LF',ECG_feats_names)) ...
                    || any(strcmp('tachogram_MF',ECG_feats_names)) ||  any(strcmp('tachogram_HF',ECG_feats_names)) ...
                    || any(strcmp('tachogram_energy_ratio',ECG_feats_names))
                
                %Handle the case were IBI could not be computed
                if(~isnan(IBI))
                    [Pt, ft] = pwelch(IBI, welch_window_size_IBI, [], [], IBI_sp);
                    %WARN: check that this is possible with the IBI sampling rate
                    %WARN: these values are sometimes negative because of the log, doesn't it appear as strange for a user ?
                    tachogram_LF = log(sum(Pt(ft>0.01 & ft<=0.08))+eps);
                    tachogram_MF = log(sum(Pt(ft>0.08 & ft<=0.15))+eps);
                    tachogram_HF = log(sum(Pt(ft>0.15 & ft<=0.5))+eps);
                    tachogram_energy_ratio = tachogram_MF/(tachogram_LF+tachogram_HF);
                else
                    tachogram_LF = NaN;
                    tachogram_MF = NaN;
                    tachogram_HF = NaN;
                    tachogram_energy_ratio = NaN;
                end
            end
        end
    end
    %Setup feature vector
    ECG_features = [];
    for i = 1:length(ECG_feats_names)
        eval(['ECG_features = cat(2, ECG_features, ' ECG_feats_names{i} ');']);
    end
else
    ECG_features = [];
end


end

