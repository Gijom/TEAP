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
config_file;
n_electrodes = length(electrode_labels.EEG);
deltaBand = zeros(1, n_electrodes);
thetaBand = zeros(1, n_electrodes);
alphaBand = zeros(1, n_electrodes);
betaBand  = zeros(1, n_electrodes);
slowAlphaBand = zeros(1, n_electrodes);
gammaBand = zeros(1, n_electrodes);
%default is 15 seconds long
%welchWindow = fs*15;

for iElec = 1:n_electrodes
	name = EEG_get_elname(iElec);
	data = EEG_get_channel(EEGSignal, name);
    %detrending the EEG signals
    data = detrend(data);
	%Welch method to compute energy of the current electrode (trial + BL)
	[PowerTrial, fTrial] = pwelch(data, [] , [], [], fs,'power');
    deltaBand(iElec) = log(sum(PowerTrial(fTrial>0 & fTrial<4)));
	thetaBand(iElec) = log(sum(PowerTrial(4<=fTrial & fTrial<8)));
	slowAlphaBand(iElec) = log(sum(PowerTrial(8<=fTrial & fTrial<10)));
    alphaBand(iElec) = log(sum(PowerTrial(8<=fTrial & fTrial<12)));
	betaBand(iElec)  = log(sum(PowerTrial(12<=fTrial & fTrial<30)));
	gammaBand(iElec) = log(sum(PowerTrial(30<fTrial)));
end


