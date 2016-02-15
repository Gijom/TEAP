%> @brief Makes sure that the given signal is an ECG one
%> Please refer to @c Signal__assert_type for more documentation
function [Signal, Bulk] = ECG__assert_type(Signal)

if(nargin ~= 1 || nargout > 2)
	error('Usage: [Signal, Bulk] = ECG__assert_type(Signal)');
end

[Signal, Bulk] = Signal__assert_type(Signal, ECG__get_signame());

