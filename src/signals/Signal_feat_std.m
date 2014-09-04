function [STD] = Signal_feat_std(Signal)
%Computes the standard deviation of a given signal
% Inputs:
%  Signal
% Outputs:
%  STD: the calculated std, using the std() function
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

STD = std(raw);


