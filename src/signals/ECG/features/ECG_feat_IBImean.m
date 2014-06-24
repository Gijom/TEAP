function [IBIMean ECGSignal] = ECG_feat_IBImean(ECGsignal)
%Computes the InterBeatInterval mean of an ECG signal
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014


%Make sure we have an ECG signal
ECG_assert_type(ECGsignal)


%If the features were already computed
if(isfield(GSRsignal, 'IBIMean'))
	Mean = ECGsignal.IBIMean;
	return;
end

%Compute the results

rawSignal = Signal_get_raw(ECGsignal);
signalSampFreq = Signal_get_samprate(ECGsignal);

newfs = 256; %Hz, as needed by rpeakdetect
ECG = downsample(rawSignal, signalSampFreq/newfs);
[hrv, R_t, R_amp, R_index, S_t, S_amp] = rpeakdetect(ECG, newfs);
[BPM IBI] = correctBPM(R_index, newfs);

ECGSignal.IBIMean = mean(IBI);
IBIMean = ECGSignal.IBIMean;
