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
%> @file GSR_feat_peaks_example.m
%> @brief Loads a GSR signal, computes it's attributes and displays the signal
% 
%Before all, load TEAP
addpath(genpath('../../../'))

%Then, we load some data:
data = csvread('GSR_example.csv');
data = data'; %put in horizontal form


%Create the signal, the sampling freq of the signal we have is 1024Hz
signal = GSR_aqn_variable(data, 1024);

%Clean the signal a bit
signal = GSR_filter_basic(signal);

%And compute the features:
[nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(signal);

%Show the signal
Signal_plot(signal);

%As now the axis are in seconds, we have to use this function to plot the points
rawSig = Signal__get_raw(signal);
Signal_plot_pts(signal, posPeaks, rawSig(posPeaks), 'r*');
%Note that we didn't had to 'hold on': the function does-it itself.


%Take a part of a signal, between 41 and 85 seconds
figure;
truncated = Signal__get_window(signal, 41, 85);
Signal_plot(truncated);

[nbPeaks ampPeaks riseTime posPeaks] = GSR_feat_peaks(truncated);
rawSig = Signal__get_raw(truncated);
Signal_plot_pts(truncated, posPeaks, rawSig(posPeaks), 'r*');

