%> @file ECG_feat_IBI_example.m
addpath(genpath('../../../'));

probe1 = csvread('ECG_example_probe1.csv');
probe2 = csvread('ECG_example_probe2.csv');

sig = ECG_aqn_variable(probe1, probe2, 1024);

IBImean = ECG_feat_IBImean(sig)
BPMmean = 60/IBImean
IBIvar = ECG_feat_IBIvar(sig)

Signal_plot(sig);
