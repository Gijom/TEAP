addpath(genpath('../../../'));

probe1 = csvread('ECG_example_probe1.csv');
probe2 = csvread('ECG_example_probe2.csv');

sig = ECG_aqn_variable(probe1, probe2, 1024);

