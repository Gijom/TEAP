addpath(genpath('../../../'));


raw = csvread('HST_example.csv')';

sig = HST_aqn_variable(raw, 1024);

sig = HST_filter_basic(sig);

HST_feat_mean(sig)

HST_feat_meanderiv(sig)

