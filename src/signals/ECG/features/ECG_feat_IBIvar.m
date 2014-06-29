function [IBIVar ECGSignal] = ECG_feat_IBIvar(ECGSignal)
%Computes the InterBeatInterval variance of an ECG signal
% Inputs:
%  ECGSignal: the ECG signal
% Outputs:
%  IBIVar: the InterBeatInterval variance
%  ECGSignal: the ECG signal with the embedded feature
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have an ECG signal
ECG_assert_type(ECGSignal)


%If the features were already computed
if(Signal_has_feature(ECGSignal, 'IBIVar'))
	feat = Signal_get_feature(ECGSignal, 'IBIVar');
	IBIVar = feat.value;
	return;
end


%Compute the results

rawSignal = Signal_get_raw(ECGSignal);
signalSampFreq = Signal_get_samprate(ECGSignal);

newfs = 256; %Hz, as needed by rpeakdetect
ECG = downsample(rawSignal, signalSampFreq/newfs);
[hrv, R_t, R_amp, R_index, S_t, S_amp] = rpeakdetect(ECG, newfs);
[BPM IBI] = correctBPM(R_index, newfs);

IBIVar = var(IBI);
ECGSignal = Signal_set_feature('IBIVar', IBIVar);
