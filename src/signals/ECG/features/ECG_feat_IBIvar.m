%> @brief Computes the InterBeatInterval variance of an ECG signal
%> @param  ECGSignal: the ECG signal
%> @retval  IBIVar: the InterBeatInterval variance
%
%> @author Copyright Guillaume Chanel 2013
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function IBIVar = ECG_feat_IBIvar(ECGSignal)


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

