function [thetaBand alphaBand betaBand slowAlpha gammaBand] = EEG_feat_bandENR(EEGSignal)
%Computes the band energy ratio (trial/baseline) for the EEG signal.
% Inputs:
%  EEGSignal: the EEG signal
% Outputs:
%  thetaBand: 1x32 vector
%  alphaBand
%  betaBand
%  slowAlpha
%  gammaBand
%
%Copyright Mohammad Soleymani 2009
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

EEGSignal = EEG__assert_type(EEGSignal);

fs = Signal__get_samprate(EEGSignal);

welchWindow = 15 * fs; %15 seconds
%NB: if you want to offset the signal (eg: take out the first 0.5 secs, use
%the Signal__get_window(Signal, 0.5) function

thetaBand = zeros(1, 32);
alphaBand = zeros(1, 32);
betaBand  = zeros(1, 32);
slowAlpha = zeros(1, 32);
gammaBand = zeros(1, 32);

for iElec = [1:32]
	name = EEG_get_elname(iElec);
	data = EEG_get_channel(EEGSignal, name);

	%Welch method to compute energy of the current electrode (trial + BL)
	[PowerTrial, fTrial] = pwelch(data, welchWindow, [], [], fs);
	thetaBand(iElec) = sum(PowerTrial(4<=fTrial & fTrial<8));
	alphaBand(iElec) = sum(PowerTrial(8<=fTrial & fTrial<12));
	slowAlpha(iElec) = sum(PowerTrial(8<=fTrial & fTrial<10));
	betaBand(iElec)  = sum(PowerTrial(12<=fTrial & fTrial<30));
	gammaBand(iElec) = sum(PowerTrial(30<fTrial));
end


