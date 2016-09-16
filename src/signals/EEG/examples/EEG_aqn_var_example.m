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
%> @file EEG_aqn_var_example.m

addpath(genpath('../../../'));

AF3 = csvread('outFile_signal_AF3')';
F3 = csvread('outFile_signal_F3')';
Fp1 = csvread('outFile_signal_Fp1')';

electrodes = [AF3; F3; Fp1];

sig = EEG_aqn_variable(['AF3'; 'F3'; 'Fp1'], electrodes, 1024);


