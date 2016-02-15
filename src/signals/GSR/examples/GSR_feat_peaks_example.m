%> @file GSR_feat_peaks_example.m
%Before all, load TEAPhysio
addpath(genpath('../../../'))

%Then, we load some data:
data = csvread('GSR_example.csv');
data = data'; %put in horizontal form


%Create the signal, the sampling freq of the signal we have is 1024Hz
signal = GSR_aqn_variable(data, 1024);

%Clean the signal a bit
signal = GSR_filter_basic(signal);

%And compute the features:
[nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(signal);

%Show the signal
Signal_plot(signal);

%As now the axis are in seconds, we have to use this function to plot the points
rawSig = Signal__get_raw(signal);
Signal_plot_pts(signal, posPeaks, rawSig(posPeaks), 'r*');
%Note that we didn't had to 'hold on': the function does-it itself.

figure

%Take a part of a signal
truncated = Signal__get_window(signal, 41, 85);
Signal_plot(truncated);

[nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(truncated);
rawSig = Signal__get_raw(truncated);
Signal_plot_pts(truncated, posPeaks, rawSig(posPeaks), 'r*');

