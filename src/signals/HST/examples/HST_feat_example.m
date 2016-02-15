%> @file HST_feat_example.m
addpath(genpath('../../../'));

%Acquire the raw signal
raw = csvread('HST_example.csv')';

%Create a signal
sig = HST_aqn_variable(raw, 1024);

%Filter the signal
sig = HST_filter_basic(sig);

%Calc the HST mean
mean = HST_feat_mean(sig)

%Calc the mean of the derivation of the hst
meanderiv = HST_feat_meanderiv(sig)

