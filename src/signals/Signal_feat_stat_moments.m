%This file is part of TEAP.
%
%TEAP is free software: you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or
%(at your option) any later version.
%
%TEAP is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with TEAP.  If not, see <http://www.gnu.org/licenses/>.
% 
%> @file Signal_feat_stat_moments.m
%> @brief Computes the statistical moments for the input signals
% 
%> @param  Signal The signal to compute
% 
%> @retval mean_: the calculated std, using the @c mean() function
%> @retval std_: the calculated std, using the @c std() function
%> @retval kurtosis_: the calculated Kurtosis, using the @c kurtosis() function
%> @retval skewness_: the calculated skewness, using the @c skewness() function
% 
%> @author Copyright Moahmmad Soleymani and Frank Villaro-Dixon, 2015
function [mean_,std_, kurtosis_, skewness_]= Signal_feat_stat_moments(Signal)

Signal__assert_mine(Signal);

raw = Signal__get_raw(Signal);

if ~isvector(raw)
	mean_ = mean(raw,2)';
	std_ = std(raw,[],2)';
	kurtosis_ = kurtosis(raw,[],2)';
	skewness_ = skewness(raw,[],2)';
else
	mean_ = mean(raw);
	std_ = std(raw);
	kurtosis_ = kurtosis(raw);
	skewness_ = skewness(raw);
end


