function IBIVar = ECG_feat_IBIvar(ECGSignal)
%Computes the InterBeatInterval variance of an ECG signal
% Inputs:
%  ECGSignal: the ECG signal
% Outputs:
%  IBIVar: the InterBeatInterval variance
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014


%Make sure we have an ECG signal
ECGSignal = ECG__assert_type(ECGSignal);


%Compute the results

rawSignal = Signal__get_raw(ECGSignal);
samprate = Signal__get_samprate(ECGSignal);

newfs = 256; %Hz, as needed by rpeakdetect
ECG = downsample(rawSignal, samprate/newfs);
[hrv, R_t, R_amp, R_index, S_t, S_amp] = rpeakdetect(ECG, newfs);
[BPM IBI] = correctBPM(R_index, newfs);

IBIVar = var(IBI);

end

