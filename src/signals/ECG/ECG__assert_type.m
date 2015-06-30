function [Signal, Bulk] = ECG__assert_type(Signal)
%Makes sure that the given signal is an ECG one
%Please refer to Signal__assert_type for more documentation

if(nargin ~= 1 || nargout > 2)
	error('Usage: [Signal, Bulk] = ECG__assert_type(Signal)');
end

[Signal, Bulk] = Signal__assert_type(Signal, ECG__get_signame());

