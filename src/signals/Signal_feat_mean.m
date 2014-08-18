function [MEAN] = Signal_feat_mean(Signal)
%Computes the mean of a signal
% Inputs:
%  Signal:
% Outputs:
%  MEAN: the mean, calculated using the mean() function
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal_assert_mine(Signal);
raw = Signal_get_raw(Signal);

MEAN = mean(raw);


