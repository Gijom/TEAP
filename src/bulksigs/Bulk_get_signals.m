%> @file Bulk_get_signals.m
%> @brief Gets the list of the signals of the bulk signal. Ex: ['GSR'; 'EEG'].

%> @param BulkSig the bulk signal

%> @retval signals the array containing the signals name (ex: ['GSR'; 'EEG'])
function [signals] = Bulk_get_signals(BulkSig)
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Bulk_assert_mine(BulkSig);

fields = fieldnames(BulkSig);

signals = [];

for i = [1:size(fields)];
	if(~strcmp(fields{i}, 'TEAPhysio'))
		signals = [fields{i}; signals];
	end
end


