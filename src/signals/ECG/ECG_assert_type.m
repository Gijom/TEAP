function Signal = ECG_assert_type(Signal)
%Makes sure that the given signal is an ECG one
%Please refer to Signal_assert_type for more documentation

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = ECG_assert_type(Signal)');
end

Signal = Signal_assert_type(Signal, ECG_get_name());

