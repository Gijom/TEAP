%Tests the GSR peak feature.


%First, we load some data:
data = csvread('GSR_example.csv');
data = data'; %put in horizontal form


%Create the signal, the sampling freq of the signal we have is 1024Hz
signal = GSR_aqn_variable(data, 1024);

%And compute the features:
[nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(signal)
