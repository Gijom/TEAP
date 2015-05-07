function EMGEnergy = EMG_energy(EMGSignal)
%Computes the InterBeatInterval mean of an EMG signal
% Inputs:
%  EMGSignal: the EMG signal
% Outputs:
%  IBIMean: the InterBeatInterval mean
%
%Copyright Guillaume Chanel 2013
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014


%Make sure we have an EMG signal
EMGSignal = EMG__assert_type(EMGSignal);


%Compute the results

rawSignal = Signal__get_raw(EMGSignal);
samprate = Signal__get_samprate(EMGSignal);
order = 8; %butterworth filter order
Fc = 20; %cutoff frequency
[b1,a1]=butter(order,Fc/(samprate/2),'high');
f_EMG = filtfilt(b1,a1,rawSignal);

EMGEnergy = mean((f_EMG).^2);

end

