function Signal = DMY_assert_type(Signal)
%Asserts that the given signal is a DMY one
%Please refer to Signal_assert_type for more and extensive documentation ;)

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = DMY_assert_type(Signal)');
end


Signal = Signal_assert_type(Signal, DMY_get_name());

