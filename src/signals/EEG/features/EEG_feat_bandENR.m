function [deltaBand, thetaBand, slowAlphaBand, alphaBand, betaBand, gammaBand] = EEG_feat_bandENR(EEGSignal)
%Computes the band energy (trial/baseline) for the EEG signal.
% Inputs:
%  EEGSignal: the EEG signal
% Outputs:
%  thetaBand: 1xN vector; N number of electrodes
%  alphaBand
%  betaBand
%  slowAlpha
%  gammaBand
%
%Copyright Mohammad Soleymani 2009
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

EEGSignal = EEG__assert_type(EEGSignal);

fs = Signal__get_samprate(EEGSignal);


%NB: if you want to offset the signal (eg: take out the first 0.5 secs, use
%the Signal__get_window(Signal, 0.5) function
n_electrodes = length(electrode_labels.EEG);
deltaBand = zeros(1, n_electrodes);
thetaBand = zeros(1, n_electrodes);
alphaBand = zeros(1, n_electrodes);
betaBand  = zeros(1, n_electrodes);
slowAlpha = zeros(1, n_electrodes);
gammaBand = zeros(1, n_electrodes);

for iElec = [1:n_electrodes]
	name = EEG_get_elname(iElec);
	data = EEG_get_channel(EEGSignal, name);

	%Welch method to compute energy of the current electrode (trial + BL)
	[PowerTrial, fTrial] = pwelch(data, [], [], [], fs,'power');
    deltaBand(iElec) = sum(PowerTrial(fTrial<4 & fTrial>fTrial(2)));
	thetaBand(iElec) = sum(PowerTrial(4<=fTrial & fTrial<8));
	slowAlphaBand(iElec) = sum(PowerTrial(8<=fTrial & fTrial<10));
    alphaBand(iElec) = sum(PowerTrial(8<=fTrial & fTrial<12));
	betaBand(iElec)  = sum(PowerTrial(12<=fTrial & fTrial<30));
	gammaBand(iElec) = sum(PowerTrial(30<fTrial));
end


