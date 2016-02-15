%> @file Signal_feat_std.m
%> @brief Computes the standard deviation of a given signal
%> @param  Signal
%> @retval  STD: the calculated std, using the @c std() function
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [STD] = Signal_feat_std(Signal)

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

STD = std(raw);


