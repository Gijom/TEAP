function IBIMean = ECG_feat_IBImean(ECGSignal)
%Computes the InterBeatInterval mean of an ECG signal
% Inputs:
%  ECGSignal: the ECG signal
% Outputs:
%  IBIMean: the InterBeatInterval mean
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014
%Modified by Guillaume Chanel


%Make sure we have an ECG signal
ECGSignal = ECG__assert_type(ECGSignal);

%Compute IBI
ECG__compute_IBI(ECGSignal);

%Compute average
IBIMean = mean(Signal__get_raw(ECGSignal.IBI));

end

