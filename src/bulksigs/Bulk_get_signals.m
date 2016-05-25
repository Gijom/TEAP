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
%> @file Bulk_get_signals.m
%> @brief Gets the list of the signals of the bulk signal. Ex: ['GSR'; 'EEG'].

%> @param BulkSig the bulk signal

%> @retval signals the array containing the signals name (ex: ['GSR'; 'EEG'])
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

function [signals] = Bulk_get_signals(BulkSig)
Bulk_assert_mine(BulkSig);

fields = fieldnames(BulkSig);

signals = [];

for i = [1:size(fields)];
	if(~strcmp(fields{i}, 'TEAPhysio'))
		signals = [fields{i}; signals];
	end
end


