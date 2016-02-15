%> @file ECG_feat_IBImean.m
%> @brief Computes the InterBeatInterval mean of an ECG signal
%> @param  ECGSignal: the ECG signal
%> @retval IBIMean: the InterBeatInterval mean
%
%> @author Copyright Guillaume Chanel 2013
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function IBIMean = ECG_feat_IBImean(ECGSignal)


%Make sure we have an ECG signal
ECGSignal = ECG__assert_type(ECGSignal);

%Compute IBI
ECG__compute_IBI(ECGSignal);

%Compute average
IBIMean = mean(Signal__get_raw(ECGSignal.IBI));

end

