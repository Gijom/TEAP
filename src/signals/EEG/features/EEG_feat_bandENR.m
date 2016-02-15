%> @file EEG_feat_bandENR.m
%> @brief Computes the band energy (trial/baseline) for the @b EEG signal.

%> @param  EEGSignal: the @b EEG signal

%> @retval  thetaBand: 1xN vector; N number of electrodes
%> @retval  alphaBand
%> @retval  betaBand
%> @retval  slowAlpha
%> @retval  gammaBand
%
%> @author Copyright Mohammad Soleymani 2009
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [deltaBand, thetaBand, slowAlphaBand, alphaBand, betaBand, gammaBand] = EEG_feat_bandENR(EEGSignal)
config_file;

EEGSignal = EEG__assert_type(EEGSignal);

fs = Signal__get_samprate(EEGSignal);
%default is 15 seconds long
welch_window_size = fs*15;
%get the signal length

sing_length = length(EEG_get_channel(EEGSignal, EEG_get_elname(1)));
n_electrodes = length(electrode_labels.EEG);
deltaBand = nan(1, n_electrodes);
thetaBand = nan(1, n_electrodes);
alphaBand = nan(1, n_electrodes);
betaBand  = nan(1, n_electrodes);
slowAlphaBand = nan(1, n_electrodes);
gammaBand = nan(1, n_electrodes);

if sing_length< welch_window_size +fs
	warning('singal too short for the welch size')
end
if sing_length< welch_window_size +1
	warning('singal too short for the welch size and this method will not work')
else
	for iElec = 1:n_electrodes
		name = EEG_get_elname(iElec);
		data = EEG_get_channel(EEGSignal, name);
		%detrending the EEG signals
		data = detrend(data);
		%Welch method to compute energy of the current electrode (trial + BL)
		[PowerTrial, fTrial] = pwelch(data, welch_window_size , [], [], fs);
		deltaBand(iElec) =     log(sum(PowerTrial(fTrial>0 & fTrial<4)));
		thetaBand(iElec) =     log(sum(PowerTrial(4<=fTrial & fTrial<8)));
		slowAlphaBand(iElec) = log(sum(PowerTrial(8<=fTrial & fTrial<10)));
		alphaBand(iElec) =     log(sum(PowerTrial(8<=fTrial & fTrial<12)));
		betaBand(iElec)  =     log(sum(PowerTrial(12<=fTrial & fTrial<30)));
		gammaBand(iElec) =     log(sum(PowerTrial(30<fTrial)));
	end
end
