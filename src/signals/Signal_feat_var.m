function [var] = Signal_feat_var(Signal)
%Computes the variance of a signal
% Inputs:
%  Signal
% Outputs:
%  var: the calculated var, using the var() function
%
%Copyright Frank Villaro-Dixon MIT LICENSE, 2014

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

var = var(raw);


