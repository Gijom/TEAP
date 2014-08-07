function Bulk_assert_mine(BulkSignal)
%Asserts that the signal is a TEAPhysio bulk signal
% Inputs:
%  BulkSignal: the signal to test
%
%Copyright Frank Villaro-Dixon Creative Commons BY-SA 4.0 2014

if(nargin ~= 1)
	error('Usage: Bulk_assert_mine(BulkSignal)');
end

if(isfield(BulkSignal, 'TEAPhysio'))
	if(BulkSignal.TEAPhysio == 'B')
		return;
	end
end

error('The signal given is not a TEAPhysio one')


%!error(Bulk_assert_mine(42))
%!error(Bulk_assert_mine())

