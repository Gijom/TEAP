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
%> @file BVP_feat_IBI_example.m
addpath(genpath('../../../')); %load the toolbox

data = csvread('BVP_example.csv')';

sig = BVP_aqn_variable(data, 512); %Sampling freq is 512 (not known from CSV)

figure;
subplot(2,1,1);
Signal_plot(sig);

sig = BVP__compute_IBI(sig);

subplot(2,1,2);
Signal_plot(sig.IBI);

IBIvar = BVP_feat_var(sig)
