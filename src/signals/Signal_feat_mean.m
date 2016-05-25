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

%> @file Signal_feat_mean.m
%> @brief Computes the mean of a signal
%> @param Signal: The signal you want to calculate the mean
%> @retval  MEAN: the mean, calculated using the mean() function
%
%> @author Copyright Frank Villaro-Dixon, BSD Simplified, 2014
function [MEAN] = Signal_feat_mean(Signal)

Signal__assert_mine(Signal);
raw = Signal__get_raw(Signal);

MEAN = mean(raw);


