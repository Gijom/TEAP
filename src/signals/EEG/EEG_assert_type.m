function Signal = EEG_assert_type(Signal)
%Asserts that the given signal is an EEG one
%Please refer to Signal__assert_type for more extensive documentation

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = EEG_assert_type(Signal)');
end

Signal = Signal__assert_type(Signal, EEG_get_signame());
