function IBIMean = ECG_feat_IBImean(ECGSignal)
%Computes the InterBeatInterval mean of an ECG signal
% Inputs:
%  ECGSignal: the ECG signal
% Outputs:
%  IBIMean: the InterBeatInterval mean
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

IBIMean = mean(IBI);

end

