function bandEnergy = EEG_feat_bandENR(EEGSignal)
%Computes the band energy ratio (trial/baseline) for the EEG signal.
% Inputs:
%  EEGSignal: the EEG signal
% Outputs:
%  bandEnergy: the feature structure containing the results
%
%Copyright Mohammad Soleymani 2009
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

EEGSignal = EEG_assert_mine(EEGSignal);

fs = Signal_get_samprate(EEGSignal);

welchWindow = 15 * fs; %15 seconds
%NB: if you want to offset the signal (eg: take out the first 0.5 secs, use
%the Signal_get_window(Signal, 0.5) function

%TODO


