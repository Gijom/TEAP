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

%> @file ECG_feat_IBI_example.m
addpath(genpath('../../../')); %load the toolbox

probe1 = csvread('ECG_example_probe1.csv'); 
probe2 = csvread('ECG_example_probe2.csv');

sig = ECG_aqn_variable(probe1, probe2, 1024);

IBImean = ECG_feat_IBImean(sig)
BPMmean = 60/IBImean
IBIvar = ECG_feat_IBIvar(sig)

Signal_plot(sig);
