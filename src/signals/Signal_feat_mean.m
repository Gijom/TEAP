function [MEAN] = Signal_feat_mean(Signal)
%Computes the mean of a signal
% Inputs:
%  Signal:
% Outputs:
%  MEAN: the mean, calculated using the mean() function
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Signal__assert_mine(Signal);
raw = Signal__get_raw(Signal);

MEAN = mean(raw);


