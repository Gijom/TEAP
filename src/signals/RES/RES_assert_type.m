function Signal = RES_assert_type(Signal)
%Makes sure that the given signal is a RES one
%If you want to know more about that, please see Signal_assert_type's document…

if(nargin ~= 1 || nargout ~= 1)
	error('Usage: Signal = RES_assert_type(Signal)');
end

Signal = Signal_assert_type(Signal, RES_get_name())

