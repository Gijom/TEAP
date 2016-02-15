%> @file ECG_feat_IBI_test.m
%!test
%! addpath(genpath('../../../'));
%!
%! probe1 = csvread('ECG_example_probe1.csv');
%! probe2 = csvread('ECG_example_probe2.csv');
%!
%! sig = ECG_aqn_variable(probe1, probe2, 1024);
%!
%! IBImean = ECG_feat_IBImean(sig);
%! IBIvar = ECG_feat_IBIvar(sig);
%!
%! assert(IBImean, 0.60692, 0.001);
%! assert(IBIvar, 0.0034596, 0.0001);
