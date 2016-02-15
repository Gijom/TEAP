%> @file Bulk_assert_mine.m
%> @brief Asserts that the signal is a TEAPhysio bulk signal

%> @param BulkSignal the signal to test

function Bulk_assert_mine(BulkSignal)
%Copyright Frank Villaro-Dixon, BSD Simplified, 2014

if(nargin ~= 1)
	error('Usage: Bulk_assert_mine(BulkSignal)');
end

if(length(BulkSignal) ~= 1)
	error(['You seem to have given a bulk signal with multiple epochs. ' ...
	       'Could you please choose the epoch you want (eg: with Bulk(1))']);
end

if(isfield(BulkSignal, 'TEAPhysio'))
	if(BulkSignal.TEAPhysio == 'B')
		return;
	end
end

error('The signal given is not a TEAPhysio one')

%!error(Bulk_assert_mine(42))
%!error(Bulk_assert_mine())

