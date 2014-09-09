function [signals] = Bulk_get_signals(BulkSig)
%Gets the list of the signals of the bulk signal. Ex: ['GSR'; 'EEG'].
% Inputs:
%  BulkSig: the bulk signal
% Outputs:
%  signals: the array containing the signals name (ex: ['GSR'; 'EEG'])
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

Bulk_assert_mine(BulkSig);

fields = fieldnames(BulkSig);

signals = [];

for i = [1:size(fields)];
	if(~strcmp(fields{i}, 'TEAPhysio'))
		signals = [fields{i}; signals];
	end
end



