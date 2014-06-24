%Tests the GSR peak feature.


%First, we load some data:
data = csvread('GSR_example.csv');
data = data'; %put in horizontal form


%Create the signal
signal = GSR_aqn_variable(data, 1024);

%And compute the features:
[nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(signal)
