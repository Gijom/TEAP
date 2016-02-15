%> @file HST_feat_means_test.m
%Tests the HST mean thingy features

%!test
%! %Before all, load TEAPhysio
%! addpath(genpath('../../../'))
%! %First, we load some data:
%! data = csvread('HST_example.csv');
%! data = data'; %put in horizontal form
%!
%!
%! %Create the signal, the sampling freq of the signal we have is 1024Hz
%! signal = HST_aqn_variable(data, 1024);
%!
%! %Clean the signal a bit
%! signal = HST_filter_basic(signal);
%!
%! %And compute the features:
%! mean = HST_feat_mean(signal);
%! meanderiv = HST_feat_meanderiv(signal);
%!
%! assert(mean, 28.92, 0.01)
%! assert(meanderiv, -7.9938e-06, 1e-06); %FIXME

