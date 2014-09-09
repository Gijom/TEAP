function [Signal] = Bulk_get_signal(BulkSignal, typeWanted)
%Takes a specific signal from a bulk signal
% Inputs:
%  BulkSignal: the bulk signal containing all the specific signals
%  typeWanted: the type you want (ex: 'HST', etc. Defined by SSS_get_signame !)
% Outputs:
%  Signal: the wanted signal. FAILS if does not exist
%
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 2)
	error('Usage: Signal = Bulk_get_signal(BulkSignal, typeWanted);');
end

Bulk_assert_mine(BulkSignal);

if(~isfield(BulkSignal, typeWanted))
	error(['The signal ' typeWanted ' is not included in this bulk signal']);
end

Signal = BulkSignal.(typeWanted);

