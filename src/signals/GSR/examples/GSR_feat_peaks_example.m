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
hold on;

%As now the axis are in seconds, we have to use this function to plot the points
rawSig = Signal_get_raw(signal);
Signal_plot_pts(signal, posPeaks, rawSig(posPeaks), 'r*');


