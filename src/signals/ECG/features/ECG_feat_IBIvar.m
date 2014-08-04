function IBIVar = ECG_feat_IBIvar(ECGSignal)
%Computes the InterBeatInterval variance of an ECG signal
% Inputs:
%  ECGSignal: the ECG signal
% Outputs:
%  IBIVar: the InterBeatInterval variance
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have an ECG signal
ECGSignal = ECG_assert_type(ECGSignal);


%Compute the results

rawSignal = Signal_get_raw(ECGSignal);
samprate = Signal_get_samprate(ECGSignal);

newfs = 256; %Hz, as needed by rpeakdetect
ECG = downsample(rawSignal, samprate/newfs);
[hrv, R_t, R_amp, R_index, S_t, S_amp] = rpeakdetect(ECG, newfs);
[BPM IBI] = correctBPM(R_index, newfs);

IBIVar = var(IBI);

end

