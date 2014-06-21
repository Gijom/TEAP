function [IBIVar ECGSignal] = ECG_feat_IBIvar(ECGsignal)
%Computes the InterBeatInterval variance of an ECG signal
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have an ECG signal
ECG_assert_type(ECGsignal)


%If the features were already computed
if(isfield(GSRsignal, 'IBIVar'))
	Mean = ECGsignal.IBIVar;
	return;
end

%Compute the results

rawSignal = Signal_get_raw(ECGsignal);
signalSampFreq = Signal_get_sampfreq(ECGsignal);

newfs = 256; %Hz, as needed by rpeakdetect
ECG = downsample(rawSignal, signalSampFreq/newfs);
[hrv, R_t, R_amp, R_index, S_t, S_amp] = rpeakdetect(ECG, newfs);
[BPM IBI] = correctBPM(R_index, newfs);

ECGSignal.IBIVar = var(IBI);
IBIVar = ECGSignal.IBIVar;
