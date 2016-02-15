%> @brief Takes a specific signal from a bulk signal

%> @param BulkSignal the bulk signal containing all the specific signals
%> @param typeWanted the type you want (ex: 'HST', etc. Defined by SSS_get_signame !)

%> @retval Signal the wanted signal. FAILS if does not exist
function [Signal] = Bulk_get_signal(BulkSignal, typeWanted)
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 2)
	error('Usage: Signal = Bulk_get_signal(BulkSignal, typeWanted);');
end

Bulk_assert_mine(BulkSignal);

if(~isfield(BulkSignal, typeWanted))
	error(['The signal ' typeWanted ' is not included in this bulk signal']);
end

Signal = BulkSignal.(typeWanted);

